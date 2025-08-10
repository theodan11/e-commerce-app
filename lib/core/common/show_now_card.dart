import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/theme/my_text_theme.dart';

class ShowNowCard extends StatelessWidget {
  final String cardTitle;
  final Color cardColor;
  final String imgPath;
  const ShowNowCard({
    super.key,
    required this.cardTitle,
    required this.cardColor,
    required this.imgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 315,
      height: 160,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: cardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: 142,
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    cardTitle,
                    style: MyTextTheme.shopNowCardHeaderText,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    child: Row(
                      children: [
                        Text(
                          "Shop now",
                          style: MyTextTheme.shopNowButtonText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Icon(
                          Icons.chevron_right_sharp,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 125,
              height: 125,
              child: Image.asset(imgPath),
            )
          ],
        ),
      ),
    );
  }
}
