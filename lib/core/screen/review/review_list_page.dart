import 'package:e_commerce_app/core/common/review_builder.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';

class ReviewListPage extends StatelessWidget {
  final List<dynamic> reviews;
  ReviewListPage({super.key, required this.reviews});

  double ratingTotal = 0;

  @override
  Widget build(BuildContext context) {
    ratingTotal = reviews.fold(0, (acc, item) {
      return acc + item['rating'];
    });

    ratingTotal = ratingTotal / reviews.length;
    return Scaffold(
        appBar: AppBar(
          title: Text("Review Product",
              style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
          centerTitle: true,
          actions: [
            const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(ratingTotal.toStringAsFixed(1)),
            const SizedBox(
              width: 4,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: ReviewBuilder(
                reviewList: reviews,
                itemC: reviews.length,
                isPhyOn: true,
                canExpanded: true,
              ),
            ),
          ),
        ));
  }
}
