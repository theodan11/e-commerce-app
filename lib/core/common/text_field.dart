import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? value;

  final IconData? icon;
  final String hintText;
  final bool isObscure;
  final int maxLine;
  final TextInputType? isNumber;

  final Function? iconBtnFunc;
  final Function(String) onChanged;
  const MyTextField(
      {super.key,
      required this.value,
      required this.hintText,
      this.isObscure = false,
      this.maxLine = 1,
      this.isNumber,
      this.iconBtnFunc,
      required this.onChanged,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: MyThemeColors.searchContainerColor),
      // margin: const EdgeInsets.symmetric(horizontal: 25),
      width: MediaQuery.of(context).size.width,
      // height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              obscureText: isObscure,
              onChanged: (value) {
                onChanged(value);
              },
              keyboardType: isNumber,
              maxLines: maxLine,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: MyTextTheme.searchHintText,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          icon != null
              ? IconButton(
                  onPressed: iconBtnFunc != null ? () => iconBtnFunc!() : null,
                  icon: Icon(icon),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
