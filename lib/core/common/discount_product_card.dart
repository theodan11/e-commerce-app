import 'package:e_commerce_app/core/common/add_to_cart_button.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/screen/login/login_page.dart';
import 'package:e_commerce_app/core/screen/product/product_detail_page.dart';
import 'package:e_commerce_app/core/services/firebase_db_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:money_formatter/money_formatter.dart';

class DiscountProductCard extends StatelessWidget {
  final String title;
  final String storeId;
  final String id;
  final String desc;
  final int stock;
  final String imagePath;
  final double price;
  final double originalPrice;
  final double rating;
  final List<dynamic> reviews;

  const DiscountProductCard(
      {super.key,
      required this.title,
      required this.storeId,
      required this.stock,
      required this.desc,
      required this.id,
      required this.imagePath,
      required this.price,
      required this.originalPrice,
      required this.rating,
      required this.reviews});

  @override
  Widget build(BuildContext context) {
    MoneyFormatter priceMoney = MoneyFormatter(amount: price);
    MoneyFormatter discountpriceMoney = MoneyFormatter(amount: originalPrice);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailPage(
                  productID: id,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              8,
            ),
          ),
          child: Material(
            elevation: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              width: 174,
              height: 268,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 15, 10, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 130,
                          width: 130,
                          child: Image.network(
                            imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
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
                                style: MyTextTheme.discountProductSaleBadgeText,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      title,
                      style: MyTextTheme.productTitle,
                      softWrap: true,
                      maxLines: 1,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "৳. ${priceMoney.output.nonSymbol}",
                      style: MyTextTheme.productPrice,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Text(
                      "৳. ${discountpriceMoney.output.nonSymbol}",
                      style: MyTextTheme.discountProductPrice,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
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
                                  rating.toString(),
                                  style: MyTextTheme.productBottomText,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${reviews.length} Reviews",
                              style: MyTextTheme.productBottomText,
                            )
                          ],
                        ),
                        // const Spacer(
                        //   flex: 1,
                        // ),
                        IconButton(
                          iconSize: 16,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Product Action",
                                        style:
                                            MyTextTheme.latestNewsHeadterText),
                                    actionsAlignment: MainAxisAlignment.start,
                                    actions: [
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          const Divider(
                                            indent: 25,
                                            endIndent: 25,
                                            thickness: .8,
                                            height: 20,
                                            color: MyThemeColors.grayText,
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          (FirebaseAuth.instance.currentUser!
                                                  .isAnonymous)
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context).pop();

                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const LoginPage()));
                                                  },
                                                  child: Text(
                                                    "Add to wishlist",
                                                    style: MyTextTheme
                                                        .latestNewsHeadterText,
                                                  ),
                                                )
                                              : GestureDetector(
                                                  onTap: () {
                                                    FirebaseDbServices()
                                                        .addWishList(
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid,
                                                            id);

                                                    Navigator.of(context).pop();

                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                          content: Text(
                                                              "Added to wishlist"),
                                                          backgroundColor:
                                                              MyThemeColors
                                                                  .categoriesGreen),
                                                    );
                                                  },
                                                  child: Text(
                                                    "Add to wishlist",
                                                    style: MyTextTheme
                                                        .latestNewsHeadterText,
                                                  ),
                                                ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          const Divider(
                                            indent: 25,
                                            endIndent: 25,
                                            thickness: .8,
                                            height: 20,
                                            color: MyThemeColors.grayText,
                                          ),
                                          const SizedBox(
                                            height: 18,
                                          ),
                                          AddToCartButton(
                                            productItem: ProductModel(
                                                id: id,
                                                imagePath: imagePath,
                                                title: title,
                                                price: price,
                                                stock: stock,
                                                storeId: storeId,
                                                desc: desc,
                                                reviews: reviews),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                });
                          },
                          icon: const Icon(
                            Icons.more_vert,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
