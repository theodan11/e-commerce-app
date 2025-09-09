import 'package:e_commerce_app/core/common/review_text_expandable.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReviewBuilder extends StatelessWidget {
  final dynamic reviewList;
  final int itemC;
  final isPhyOn;
  final canExpanded;
  const ReviewBuilder({
    super.key,
    required this.reviewList,
    required this.itemC,
    this.isPhyOn = false,
    this.canExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemC,
      // physics: AlwaysScrollableScrollPhysics,
      physics: isPhyOn
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        ReviewModel review = ReviewModel.fromJSON(reviewList[index]);
        // print(review);
        DateTime dt = review.createdAt.toDate();
        dynamic fomdt = DateFormat("MMM dd yyyy").format(dt);
        return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 120.0),
          child: SizedBox(
            // height: ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CircleAvatar(
                          child: (review.imagePath == '')
                              ? const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 35,
                                )
                              : Image.network(review.imagePath!),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                      child: Text(
                        review.userName,
                        style: MyTextTheme.reviewName,
                      ),
                    ),
                    Text(
                      fomdt,
                      style: MyTextTheme.reviewName,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 45,
                    ),
                    (review.rating < 1)
                        ? const Icon(
                            Icons.star_border,
                            color: MyThemeColors.grayText,
                          )
                        : const Icon(
                            Icons.star_rate,
                            color: Colors.amber,
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    review.rating < 2
                        ? const Icon(
                            Icons.star_border,
                            color: MyThemeColors.grayText,
                          )
                        : const Icon(
                            Icons.star_rate,
                            color: Colors.amber,
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    review.rating < 3
                        ? const Icon(
                            Icons.star_border,
                            color: MyThemeColors.grayText,
                          )
                        : const Icon(
                            Icons.star_rate,
                            color: Colors.amber,
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    review.rating < 4
                        ? const Icon(
                            Icons.star_border,
                            color: MyThemeColors.grayText,
                          )
                        : const Icon(
                            Icons.star_rate,
                            color: Colors.amber,
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    review.rating < 5
                        ? const Icon(
                            Icons.star_border,
                            color: MyThemeColors.grayText,
                          )
                        : const Icon(
                            Icons.star_rate,
                            color: Colors.amber,
                          ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(review.rating.toString()),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 45),
                    child: ReviewTextExpandable(
                      textContent: review.review,
                      canExpandable: canExpanded,
                    )
                    // Text(
                    //   review.review,
                    //   style: MyTextTheme.reviewContent,
                    //   maxLines: 3,
                    // ),
                    )
              ],
            ),
          ),
        );
      },
    );
  }
}
