import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';

class HeaderAndSeeAll extends StatelessWidget {
  final String headerTitle;
  final String btnTitle;
  final bool isSeeAllVis;
  const HeaderAndSeeAll(
      {super.key,
      required this.headerTitle,
      this.isSeeAllVis = true,
      this.btnTitle = "See All"});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headerTitle,
          style: MyTextTheme.headerTextStyle,
        ),
        isSeeAllVis
            ? GestureDetector(
                onTap: () {},
                child: Text(
                  btnTitle,
                  style: MyTextTheme.seeAll,
                ),
              )
            : const SizedBox(
                width: 2,
              )
      ],
    );
  }
}
