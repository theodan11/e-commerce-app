import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';

class ReviewListPage extends StatelessWidget {
  final dynamic reviews;
  const ReviewListPage({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Review Product",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ],
      ),
    );
  }
}
