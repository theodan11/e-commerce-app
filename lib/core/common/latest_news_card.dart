import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LatestNewsCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Timestamp nDate;
  final String imgPath;
  final Function onTapFunc;
  const LatestNewsCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.nDate,
    required this.imgPath,
    required this.onTapFunc,
  });

  @override
  Widget build(BuildContext context) {
    Timestamp time = nDate;
    DateTime dateTime = time.toDate();
    String formatDate = DateFormat('dd-MM-yyyy').format(dateTime);
    return GestureDetector(
      onTap: () {
        onTapFunc();
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 100, maxWidth: 550),
        child: SizedBox(
          width: 325,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FittedBox(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: MyTextTheme.latestNewsHeadterText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        subTitle.length > 35
                            ? "${subTitle.substring(0, 35)}..."
                            : subTitle,
                        style: MyTextTheme.latestNewsSubTitleText,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        formatDate,
                        style: MyTextTheme.latestNewsDate,
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    imgPath,
                    errorBuilder: (context, error, stacktrace) {
                      return const Icon(Icons.broken_image_outlined);
                    },
                    scale: 1.0,
                    fit: BoxFit.cover,
                    alignment: Alignment.topLeft,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
