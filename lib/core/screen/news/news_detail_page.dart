import 'package:e_commerce_app/core/common/header_and_see_all.dart';
import 'package:e_commerce_app/core/screen/news/news_page.dart';
import 'package:e_commerce_app/core/services/firebase_db_services.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';

class NewsDetailPage extends StatelessWidget {
  final String newsId;

  const NewsDetailPage({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? newsItem;
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
          future: FirebaseDbServices().fetchSingleNews(newsId),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: MyThemeColors.primaryColor,
                ),
              );
            }

            if (snapShot.hasData) {
              newsItem = snapShot.data;
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
                                      errorBuilder:
                                          (context, error, stacktrace) {
                                        return const Icon(
                                            Icons.broken_image_outlined);
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: SizedBox(
                              child: Image.network(
                                newsItem!["imagePath"],
                                errorBuilder: (context, error, stacktrace) {
                                  return const Icon(
                                    Icons.broken_image_outlined,
                                    size: 50,
                                  );
                                },
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const NewsPage()));
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
