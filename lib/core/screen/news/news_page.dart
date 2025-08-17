import 'package:e_commerce_app/core/common/latest_news_card.dart';
import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/dummyData/dummy_news_list.dart';
import 'package:e_commerce_app/core/dummyData/news.dart';
import 'package:e_commerce_app/core/screen/news/news_detail_page.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/theme/my_text_theme.dart';

class NewsPage extends StatelessWidget {
  NewsPage({super.key});
  List<News> newsList = DummyNewsList.newsList;

  @override
  Widget build(BuildContext context) {
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
                child: ListView.separated(
                    itemCount: newsList.length,
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
