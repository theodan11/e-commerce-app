import 'package:e_commerce_app/core/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';

import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String imgPath;
  final double price;
  final double rating;
  final int numOfReviews;

  const ProductCard(
      {super.key,
      required this.title,
      required this.imgPath,
      required this.price,
      required this.rating,
      required this.numOfReviews});

  @override
  Widget build(BuildContext context) {
    MoneyFormatter money = MoneyFormatter(amount: price);
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            8,
          ),
        ),
        child: GestureDetector(
          onTap: () {},
          child: Material(
            elevation: 2,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              width: 168,
              // height: 268,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 130,
                      width: 130,
                      child: Image.asset(
                        imgPath,
                        fit: BoxFit.cover,
                      ),
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
                      "৳. ${money.output.nonSymbol}",
                      style: MyTextTheme.productPrice,
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
