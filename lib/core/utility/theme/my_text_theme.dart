import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextTheme {
  MyTextTheme._();

  static final TextStyle appBarTitle = GoogleFonts.dmSans(
    fontWeight: FontWeight.bold,
    fontSize: 18,
    color: MyThemeColors.primaryColor,
  );

  static final TextStyle searchHintText = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: MyThemeColors.searchHintTextColor,
  );

  static final TextStyle bottomNavigationLabel = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 10,
    color: MyThemeColors.textNaviColor,
  );

  static final TextStyle headerTextStyle = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    color: MyThemeColors.textNaviColor,
  );

  static final TextStyle seeAll = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: MyThemeColors.primaryColor,
  );

  static final TextStyle productTitle = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: MyThemeColors.textNaviColor,
  );

  static final TextStyle productPrice = GoogleFonts.dmSans(
    fontWeight: FontWeight.bold,
    fontSize: 12,
    color: MyThemeColors.productPriceColor,
  );

  static final TextStyle productBottomText = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  );

  static final TextStyle discountProductSaleBadgeText = GoogleFonts.dmSans(
    fontWeight: FontWeight.bold,
    fontSize: 10,
    color: MyThemeColors.whiteText,
  );

  static final TextStyle discountProductPrice = GoogleFonts.dmSans(
    fontWeight: FontWeight.bold,
    fontSize: 10,
    decoration: TextDecoration.lineThrough,
    color: MyThemeColors.grayText,
  );

  static final TextStyle shopNowCardHeaderText = GoogleFonts.dmSans(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    // height: 0.3,
    color: MyThemeColors.whiteText,
  );

  static final TextStyle shopNowButtonText = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Colors.white38,
  );

  static final TextStyle latestNewsHeadterText = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: MyThemeColors.latestNewsHeaderTitleColor,
  );

  static final TextStyle latestNewsSubTitleText = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: MyThemeColors.latestNewsHeaderTitleColor,
  );

  static final TextStyle latestNewsDate = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: MyThemeColors.grayText,
  );

  static final TextStyle loginPageHeaderText = GoogleFonts.dmSans(
    fontWeight: FontWeight.bold,
    fontSize: 25,
    color: MyThemeColors.textNaviColor,
  );

  static final TextStyle loginPageSubHeaderText = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: MyThemeColors.grayText,
  );

  static final TextStyle loginPageLabel = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: MyThemeColors.textNaviColor,
  );

  static final TextStyle newsDescText = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    color: MyThemeColors.textNaviColor,
  );

  static final TextStyle productDetailHeaderText = GoogleFonts.dmSans(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: MyThemeColors.textNaviColor,
  );

  static final TextStyle availableProductText = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    color: MyThemeColors.categoriesGreen,
  );

  static final TextStyle reviewName = GoogleFonts.dmSans(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: MyThemeColors.textNaviColor,
  );

  static final TextStyle reviewContent = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: MyThemeColors.textNaviColor,
  );

  static final TextStyle reviewDate = GoogleFonts.dmSans(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: MyThemeColors.grayText,
  );
}
