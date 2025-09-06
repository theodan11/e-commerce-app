import 'package:e_commerce_app/core/common/latest_news_card.dart';
import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/news_cubit/news_list_cubit.dart';
import 'package:e_commerce_app/core/cubit/news_cubit/news_list_state.dart';

import 'package:e_commerce_app/core/screen/news/news_detail_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Future<void> fetchNews() async {
    await context.read<NewsListCubit>().fetchNewsList();
  }

  @override
  void initState() {
    fetchNews();
    super.initState();
  }

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
                  child: BlocBuilder<NewsListCubit, NewsListState>(
                      builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: MyThemeColors.primaryColor,
                        ),
                      );
                    }

                    if (state.error.isNotEmpty) {
                      return Center(
                        child: SizedBox(height: 130, child: Text(state.error)),
                      );
                    }
                    if (state.newsList.isEmpty) {
                      return const Center(
                        child: Text("No News"),
                      );
                    }
                    // print(state.newsList.length);

                    return ListView.separated(
                        itemCount: state.newsList.length,
                        itemBuilder: (context, index) {
                          var singleNews = state.newsList[index];
                          return LatestNewsCard(
                            imgPath: singleNews.imagePath,
                            nDate: singleNews.nDate,
                            subTitle: singleNews.desc,
                            title: singleNews.title,
                            onTapFunc: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailPage(
                                    newsId: singleNews.id,
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
                  })),
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
