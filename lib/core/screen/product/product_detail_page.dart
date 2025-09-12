import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/common/add_to_cart_button.dart';
import 'package:e_commerce_app/core/common/discount_product_card.dart';
import 'package:e_commerce_app/core/common/header_and_see_all.dart';
import 'package:e_commerce_app/core/common/review_builder.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_list_cubit.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_list_state.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/screen/review/review_list_page.dart';
import 'package:e_commerce_app/core/screen/review/write_a_review.dart';
import 'package:e_commerce_app/core/screen/seller/seller_detail_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/services/firebase_db_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_formatter/money_formatter.dart';

class ProductDetailPage extends StatelessWidget {
  final String productID;
  dynamic productItem = [];

  dynamic storeInfo = {};

  ProductDetailPage({super.key, required this.productID});

  Future<Map<String, dynamic>> fetchStoreInfo(
      Map<String, dynamic> productItem) async {
    try {
      DocumentSnapshot result = await FirebaseFirestore.instance
          .collection("store")
          .doc(productItem['storeId'])
          .get();
      Map<String, dynamic> storeInfo = result.data() as Map<String, dynamic>;
      storeInfo['id'] = result.id;
      return storeInfo;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> fetchSingleProduct() async {
    try {
      DocumentSnapshot result = await FirebaseFirestore.instance
          .collection("products")
          .doc(productID)
          .get();

      Map<String, dynamic> productItem = result.data() as Map<String, dynamic>;
      storeInfo = await fetchStoreInfo(productItem);
      return productItem;
    } on FirebaseException catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Product",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: FutureBuilder(
                future: fetchSingleProduct(),
                builder: (context, snapShot) {
                  if (snapShot.connectionState == ConnectionState.waiting ||
                      !snapShot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: MyThemeColors.primaryColor,
                      ),
                    );
                  }
                  int rateAcc = snapShot.data!['reviews'].fold(0, (prev, item) {
                    return prev + item['rating'];
                  });
                  double avgRating = rateAcc / snapShot.data!['reviews'].length;
                  // double avgRating = rateAcc / snapShot.data!['reviews'].length;
                  // int rateAcc = 2;

                  productItem =
                      ProductModel.fromJSON(snapShot.data!, productID);
                  // print(productItem);
                  MoneyFormatter money =
                      MoneyFormatter(amount: productItem.price);
                  snapShot.data!["formattedAmount"] = money;

                  MoneyFormatter discountpriceMoney =
                      MoneyFormatter(amount: productItem.originalPrice);
                  // print("this is product: $productItem");
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 325,
                          height: 300,
                          child: Image.network(
                            snapShot.data!['imagePath'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      (snapShot.data!['isDiscount'] != null &&
                              snapShot.data!['isDiscount'] == true)
                          ? Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: MyThemeColors.productPriceColor,
                              ),
                              width: 40,
                              height: 20,
                              child: Center(
                                child: Text(
                                  "SALE",
                                  style:
                                      MyTextTheme.discountProductSaleBadgeText,
                                ),
                              ),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        snapShot.data!['name'],
                        style: MyTextTheme.productDetailHeaderText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "৳ ${snapShot.data!['formattedAmount'].output.nonSymbol}",
                        style: MyTextTheme.productPrice.copyWith(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      (snapShot.data!['isDiscount'] != null &&
                              snapShot.data!['isDiscount'] == true)
                          ? Text(
                              "৳. ${discountpriceMoney.output.nonSymbol}",
                              style: MyTextTheme.discountProductPrice
                                  .copyWith(fontSize: 14),
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 13,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 10,
                                  color: MyThemeColors.ratingStarColor,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  avgRating.isNaN
                                      ? 0.toString()
                                      : avgRating.toStringAsFixed(1),
                                  style: MyTextTheme.productBottomText,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  "${snapShot.data!['reviews'].length} Reviews",
                                  style: MyTextTheme.productBottomText,
                                )
                              ],
                            ),
                            snapShot.data!['stock'] >= 1
                                ? Text(
                                    "Available: ${snapShot.data!['stock']}",
                                    style: MyTextTheme.availableProductText,
                                  )
                                : Text("Out of stock",
                                    style: MyTextTheme.availableProductText
                                        .copyWith(
                                      color: MyThemeColors.grayText,
                                    ))
                          ]),
                      const SizedBox(
                        height: 30,
                      ),
                      const Divider(
                        indent: 8,
                        endIndent: 8,
                        thickness: .8,
                        height: 20,
                        color: MyThemeColors.grayText,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SellerDetailPage(
                                storeId: storeInfo['id'],
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: SizedBox(
                                  width: 45,
                                  height: 45,
                                  child: Image.network(storeInfo['imagePath'])),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  storeInfo['storeName'],
                                  style: MyTextTheme.latestNewsHeadterText,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(children: [
                                  Text(
                                    "Official Store",
                                    style: MyTextTheme.latestNewsHeadterText,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Icon(
                                    Icons.verified_user_rounded,
                                    color: MyThemeColors.primaryColor,
                                  )
                                ]),
                              ],
                            ),
                   
                            const Icon(Icons.chevron_right_rounded)
                          ],
                        ),
                      ),
                      const Divider(
                        indent: 8,
                        endIndent: 8,
                        thickness: .8,
                        height: 20,
                        color: MyThemeColors.grayText,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const HeaderAndSeeAll(
                        headerTitle: "Description Product",
                        isSeeAllVis: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        snapShot.data!['desc'],
                        style: MyTextTheme.newsDescText,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Divider(
                        indent: 25,
                        endIndent: 25,
                        thickness: .8,
                        height: 20,
                        color: MyThemeColors.grayText,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const HeaderAndSeeAll(
                        headerTitle: "Rate this Product",
                        isSeeAllVis: false,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Tell us what you think",
                        style: MyTextTheme.newsDescText
                            .copyWith(letterSpacing: -1),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  WriteAReview(productID: productID)));
                        },
                        child: Text(
                          "Write a Review",
                          style: MyTextTheme.loginPageSubHeaderText
                              .copyWith(color: MyThemeColors.primaryColor),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      HeaderAndSeeAll(
                        headerTitle:
                            "Reviews (${snapShot.data!['reviews'].length})",
                        btnTitle: avgRating.isNaN
                            ? 0.toString()
                            : avgRating.toStringAsFixed(2),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: snapShot.data!['reviews'].length > 3
                            ? 360
                            : snapShot.data!['reviews'].length * 120,
                        child: ReviewBuilder(
                          reviewList: snapShot.data!['reviews'],
                          itemC: snapShot.data!['reviews'].length > 3
                              ? 3
                              : snapShot.data!['reviews'].length,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ReviewListPage(
                                  reviews: snapShot.data!['reviews'])));
                        },
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: MyThemeColors.textNaviColor)),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 30,
                          ),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "See All Reviews",
                                style: MyTextTheme.productTitle,
                              )),
                        ),
                      ),
                      const HeaderAndSeeAll(
                        headerTitle: "Featured Product",
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      BlocBuilder<ProductListCubit, ProductListState>(
                          builder: (context, state) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          height: 280,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: state.productList.length,
                            itemBuilder: (context, index) {
                              dynamic productItem = state.productList[index];
                              // print(productItem.id);
                              return DiscountProductCard(
                                  productItem: productItem);
                            },
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 36,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                if (FirebaseAuth.instance.currentUser != null) {
                                  try {
                                    FirebaseDbServices().addWishList(
                                        FirebaseAuth.instance.currentUser!.uid,
                                        productItem.id);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Added to wishlist"),
                                        backgroundColor:
                                            MyThemeColors.categoriesGreen,
                                      ),
                                    );
                                  } catch (e) {
                                    throw Exception(e);
                                  }
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: MyThemeColors.productPriceColor),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Add to wishlist",
                                          style: MyTextTheme.searchHintText
                                              .copyWith(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: AddToCartButton(productItem: productItem),
                          ),
                        ],
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
