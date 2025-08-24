import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/common/header_and_see_all.dart';

import 'package:e_commerce_app/core/screen/news/news_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';

import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';

class NewsDetailPage extends StatelessWidget {
  final String newsID;

  const NewsDetailPage({super.key, required this.newsID});

  @override
  Widget build(BuildContext context) {
    // print(newItem.imgPath);
    Map<String, dynamic>? newsItem;
    Future<void>? fetchSingleNews() async {
      try {
        var result = await FirebaseFirestore.instance
            .collection("news")
            .doc(newsID)
            .get();
        if (result.exists) {
          newsItem = result.data();
        }
      } on FirebaseException catch (e) {
        throw Exception("Something went wrong while fetching news. $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined))
        ],
      ),
      body: FutureBuilder(
          future: fetchSingleNews(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: MyThemeColors.primaryColor,
                ),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: AspectRatio(
                        aspectRatio: 1.625,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(
                                    newsItem!['title'],
                                    style: MyTextTheme.headerTextStyle,
                                  ),
                                  content: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      newsItem!["imagePath"],
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              child: Image.network(
                                newsItem!["imagePath"],
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      newsItem!["title"],
                      style: MyTextTheme.latestNewsHeadterText
                          .copyWith(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      newsItem!["title"],
                      style: MyTextTheme.latestNewsDate,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(newsItem!["desc"], style: MyTextTheme.newsDescText),
                    const SizedBox(
                      height: 30,
                    ),
                    const HeaderAndSeeAll(
                      headerTitle: "Other News",
                      isSeeAllVis: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // SizedBox(
                    //   width: 450,
                    //   height: 300,
                    //   child: ListView.separated(
                    //     itemCount: 2,
                    //     itemBuilder: (context, index) {
                    //       News singleNews = newsList[index];
                    //       return LatestNewsCard(
                    //         imgPath: singleNews.imgPath,
                    //         // nDate: singleNews.nDate,
                    //         subTitle: singleNews.title,
                    //         title: singleNews.title,
                    //         onTapFunc: () {
                    //           Navigator.of(context).push(MaterialPageRoute(
                    //               builder: (context) =>
                    //                   NewsDetailPage(newsIndex: index)));
                    //         },
                    //       );
                    //     },
                    //     separatorBuilder: (context, index) {
                    //       return const Column(
                    //         children: [
                    //           SizedBox(
                    //             height: 18,
                    //           ),
                    //           Divider(
                    //             indent: 25,
                    //             endIndent: 25,
                    //             thickness: .8,
                    //             height: 20,
                    //             color: MyThemeColors.grayText,
                    //           ),
                    //           SizedBox(
                    //             height: 18,
                    //           )
                    //         ],
                    //       );
                    //     },
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => NewsPage()));
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: MyThemeColors.textNaviColor)),
                        margin: const EdgeInsets.symmetric(
                          // horizontal: 15,
                          vertical: 30,
                        ),
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "See All News",
                              style: MyTextTheme.productTitle,
                            )),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
