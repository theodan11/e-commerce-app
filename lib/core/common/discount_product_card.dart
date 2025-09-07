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
  final ProductModel productItem;
  const DiscountProductCard({
    super.key,
    required this.productItem,
  });

  @override
  Widget build(BuildContext context) {
    MoneyFormatter priceMoney = MoneyFormatter(amount: productItem.price);
    MoneyFormatter discountpriceMoney =
        MoneyFormatter(amount: productItem.originalPrice);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductDetailPage(
                  productID: productItem.id,
                )));
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
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
              height: 160,
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
                            productItem.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        productItem.isDiscount
                            ? Positioned(
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
                                      style: MyTextTheme
                                          .discountProductSaleBadgeText,
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      productItem.title,
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
                    productItem.isDiscount
                        ? Text(
                            "৳. ${discountpriceMoney.output.nonSymbol}",
                            style: MyTextTheme.discountProductPrice,
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 6,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MediaQuery.of(context).size.width >= 530
                              ? Row(
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
                                          "0",
                                          style: MyTextTheme.productBottomText,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${productItem.reviews.length} Reviews",
                                        style: MyTextTheme.productBottomText,
                                        softWrap: true,
                                      ),
                                    )
                                  ],
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          "0",
                                          style: MyTextTheme.productBottomText,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${productItem.reviews.length} Reviews",
                                      style: MyTextTheme.productBottomText,
                                      softWrap: true,
                                    )
                                  ],
                                ),
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
                                          (FirebaseAuth.instance.currentUser ==
                                                  null)
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
                                                            productItem.id);

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
                                            productItem: productItem,
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
