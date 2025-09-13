import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';

class CategoryItem {
  const CategoryItem._();
  static final List<Map<String, dynamic>> categoryList = [
    {
      "lable": "All",
      "imagePath": "assets/images/check-circle.svg",
      "bgColor": MyThemeColors.categoriesAll.withAlpha(60),
      "color": MyThemeColors.categoriesAll,
    },
    {
      "lable": "Food",
      "imagePath": "assets/images/strawberry.svg",
      "bgColor": MyThemeColors.categoriesGreen.withAlpha(60),
      "color": MyThemeColors.categoriesGreen,
    },
    {
      "lable": "Vegetable",
      "imagePath": "assets/images/salad.svg",
      "bgColor": MyThemeColors.categoriesOrange.withAlpha(60),
      "color": MyThemeColors.categoriesOrange,
    },
    {
      "lable": "Fashion",
      "imagePath": "assets/images/clothes-hanger.svg",
      "bgColor": MyThemeColors.categoriesYellow.withAlpha(60),
      "color": MyThemeColors.categoriesYellow,
    },
    {
      "lable": "Gadget",
      "imagePath": "assets/images/keyboard.svg",
      "bgColor": MyThemeColors.categoriesPurple.withAlpha(60),
      "color": MyThemeColors.categoriesPurple,
    },
    {
      "lable": "Meat",
      "imagePath": "assets/images/steak.svg",
      "bgColor": MyThemeColors.categoriesRed.withAlpha(60),
      "color": MyThemeColors.categoriesRed,
    },
    {
      "lable": "Shoe",
      "imagePath": "assets/images/shoe-prints.svg",
      "bgColor": MyThemeColors.categoriesOrange.withAlpha(60),
      "color": MyThemeColors.categoriesOrange,
    },
  ];
}
