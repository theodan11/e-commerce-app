import 'package:e_commerce_app/core/theme/my_text_theme.dart';
import 'package:flutter/material.dart';

class HeaderAndSeeAll extends StatelessWidget {
  final String headerTitle;
  final bool isSeeAllVis;
  const HeaderAndSeeAll(
      {super.key, required this.headerTitle, this.isSeeAllVis = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
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
                    "See All",
                    style: MyTextTheme.seeAll,
                  ),
                )
              : const SizedBox(
                  width: 2,
                )
        ],
      ),
    );
  }
}
