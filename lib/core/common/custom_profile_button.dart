import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

class CustomProfileButton extends StatelessWidget {
  final VoidCallback onTapFunc;
  final String btnTitle;
  final IconData icon;
  final Color iconColor;
  const CustomProfileButton({
    super.key,
    required this.onTapFunc,
    required this.btnTitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTapFunc();
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyThemeColors.grayBackground,
          border: const BorderDirectional(
            bottom: BorderSide(width: 0.2),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                btnTitle,
                style: MyTextTheme.headerTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
