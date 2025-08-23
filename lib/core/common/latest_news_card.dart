import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';

class LatestNewsCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final String nDate;
  final String imgPath;
  final Function onTapFunc;
  const LatestNewsCard(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.nDate,
      required this.imgPath,
      required this.onTapFunc});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapFunc();
      },
      child: FittedBox(
        child: SizedBox(
          width: 325,
          child: Row(
            children: [
              SizedBox(
                width: 225,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: MyTextTheme.latestNewsHeadterText,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      subTitle,
                      style: MyTextTheme.latestNewsSubTitleText,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      nDate,
                      style: MyTextTheme.latestNewsDate,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                  imgPath,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
