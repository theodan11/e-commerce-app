import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

class ReviewTextExpandable extends StatefulWidget {
  final String textContent;
  int trimLine;
  bool canExpandable;
  bool isExpanded = false;
  ReviewTextExpandable({
    super.key,
    required this.textContent,
    this.trimLine = 1,
    this.canExpandable = false,
  });

  @override
  State<ReviewTextExpandable> createState() => _ReviewTextExpandableState();
}

class _ReviewTextExpandableState extends State<ReviewTextExpandable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.textContent,
          style: MyTextTheme.reviewContent,
          maxLines: widget.isExpanded ? null : widget.trimLine,
        ),
        widget.canExpandable
            ? Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isExpanded = !widget.isExpanded;
                    });
                  },
                  child: widget.isExpanded
                      ? Text(
                          "Show less",
                          style: MyTextTheme.loginPageSubHeaderText
                              .copyWith(color: MyThemeColors.grayText),
                        )
                      : widget.textContent.length >= 51
                          ? Text(
                              "Show more",
                              style: MyTextTheme.loginPageSubHeaderText
                                  .copyWith(color: MyThemeColors.grayText),
                            )
                          : const SizedBox(),
                ),
              )
            : const SizedBox()
      ],
    );
  }
}
