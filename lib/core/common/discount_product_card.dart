import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';
import 'package:money_formatter/money_formatter.dart';

class DiscountProductCard extends StatelessWidget {
  final String title;
  final String imgPath;
  final double price;
  final double originalPrice;
  final double rating;
  final int numOfReviews;

  const DiscountProductCard(
      {super.key,
      required this.title,
      required this.imgPath,
      required this.price,
      required this.originalPrice,
      required this.rating,
      required this.numOfReviews});

  @override
  Widget build(BuildContext context) {
    MoneyFormatter priceMoney = MoneyFormatter(amount: price);
    MoneyFormatter discountpriceMoney = MoneyFormatter(amount: originalPrice);
    return GestureDetector(
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
              width: 168,
              // height: ,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 130,
                          width: 130,
                          child: Image.asset(
                            imgPath,
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
                      height: 20,
                    ),
                    Text(
                      title,
                      style: MyTextTheme.productTitle,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "৳. ${priceMoney.output.nonSymbol}",
                      style: MyTextTheme.productPrice,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "৳. ${discountpriceMoney.output.nonSymbol}",
                      style: MyTextTheme.discountProductPrice,
                    ),
                    const SizedBox(
                      height: 8,
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
                              width: 8,
                            ),
                            Text(
                              "$numOfReviews Reviews",
                              style: MyTextTheme.productBottomText,
                            )
                          ],
                        ),
                        IconButton(
                          iconSize: 16,
                          onPressed: () {},
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
