import 'package:e_commerce_app/core/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  const SearchTextField({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          const BoxDecoration(color: MyThemeColors.searchContainerColor),
      margin: const EdgeInsets.symmetric(horizontal: 25),
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(
                hintText: "Search Product Name",
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }
}
