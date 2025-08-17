import 'package:e_commerce_app/core/common/header_and_see_all.dart';
import 'package:e_commerce_app/core/common/latest_news_card.dart';
import 'package:e_commerce_app/core/dummyData/dummy_news_list.dart';
import 'package:e_commerce_app/core/dummyData/news.dart';
import 'package:e_commerce_app/core/screen/news/news_page.dart';
import 'package:e_commerce_app/core/theme/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';

class NewsDetailPage extends StatelessWidget {
  final int newsIndex;

  const NewsDetailPage({super.key, required this.newsIndex});

  @override
  Widget build(BuildContext context) {
    final News newItem = DummyNewsList.newsList[newsIndex];
    List<News>? _filterNews(List<News> newsList) {
      List<News> filteredItem = [];
      for (int i = 0; i < newsList.length; i++) {
        if (newsList[i].title != newItem.title) {
          filteredItem.add(newsList[i]);
        }
      }
      return filteredItem;
    }

    final List<News> newsList = _filterNews(DummyNewsList.newsList)!;

    ;
    // print(newItem.imgPath);
    return Scaffold(
      appBar: AppBar(
        title: Text("News Detail",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.625,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: SizedBox(
                    child: Image.asset(
                      newItem.imgPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                newItem.title,
                style: MyTextTheme.latestNewsHeadterText.copyWith(fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                newItem.nDate,
                style: MyTextTheme.latestNewsDate,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(newItem.desc, style: MyTextTheme.newsDescText),
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
              SizedBox(
                height: 300,
                child: ListView.separated(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      News singleNews = newsList[index];
                      return LatestNewsCard(
                        imgPath: singleNews.imgPath,
                        nDate: singleNews.nDate,
                        subTitle: singleNews.title,
                        title: singleNews.title,
                        onTapFunc: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  NewsDetailPage(newsIndex: index)));
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
                    }),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => NewsPage()));
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: MyThemeColors.textNaviColor)),
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
      ),
    );
  }
}
