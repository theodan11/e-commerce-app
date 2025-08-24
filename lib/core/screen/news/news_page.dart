import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/common/latest_news_card.dart';
import 'package:e_commerce_app/core/common/text_field.dart';

import 'package:e_commerce_app/core/screen/news/news_detail_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> newsList = [];
    Future<void>? fetchNews() async {
      newsList = [];
      try {
        await FirebaseFirestore.instance
            .collection("news")
            .get()
            .then((querySnapshot) {
          for (var doc in querySnapshot.docs) {
            newsList.add({
              'title': doc['title'],
              'desc': doc['desc'],
              'imagePath': doc['imagePath'],
              'userID': doc['userID'],
              '_id': doc.id
            });
          }
          // print(newsList[0]["title"]);
        });
      } on FirebaseException catch (e) {
        throw Exception("Something went wrong while fetching news. $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("News",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: MyTextField(
                onChanged: (value) {},
                value: '',
                hintText: "Search News",
                icon: Icons.search,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: FutureBuilder(
                    future: fetchNews(),
                    builder: (context, snaphot) {
                      if (snaphot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: MyThemeColors.primaryColor,
                          ),
                        );
                      }

                      return ListView.separated(
                          itemCount: newsList.length,
                          itemBuilder: (context, index) {
                            var singleNews = newsList[index];
                            return LatestNewsCard(
                              imgPath: singleNews["imagePath"],
                              // nDate: singleNews["nDate"],
                              subTitle: singleNews["desc"],
                              title: singleNews["title"],
                              onTapFunc: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailPage(
                                      newsID: singleNews['_id'],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Column(
                              children: [
                                SizedBox(
                                  height: 18,
                                ),
                                Divider(
                                  indent: 25,
                                  endIndent: 25,
                                  thickness: .8,
                                  height: 20,
                                  color: MyThemeColors.grayText,
                                ),
                                SizedBox(
                                  height: 18,
                                )
                              ],
                            );
                          });
                    }),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
