import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/common/banner_card.dart';
import 'package:e_commerce_app/core/common/header_and_see_all.dart';
import 'package:e_commerce_app/core/common/product_card.dart';
import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/common/show_now_card.dart';
import 'package:e_commerce_app/core/cubit/product_list/product_list_cubit.dart';
import 'package:e_commerce_app/core/cubit/product_list/product_list_state.dart';
import 'package:e_commerce_app/core/cubit/product_list/product_model.dart';
import 'package:e_commerce_app/core/screen/news/news_page.dart';
import 'package:e_commerce_app/core/screen/product/product_detail_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> fetchData() async {
    await context.read<ProductListCubit>().fetchProduct();
  }

  @override
  void initState() {
    fetchData();

    super.initState();
  }

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextField(
              onChanged: (value) {},
              value: '',
              hintText: "Search Product Name",
              icon: Icons.search,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: SizedBox(
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  BannerCard(),
                  BannerCard(),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: HeaderAndSeeAll(
              headerTitle: "Categories",
            ),
          ),
          const SizedBox(
            height: 16,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              height: 80,
              child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 80,
                      height: 76,
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: const Color(0x483A9B7B),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child:
                                  Image.asset("assets/images/Vegetable 1.png"),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text("Foods", style: MyTextTheme.productTitle)
                        ],
                      ),
                    );
                  }),
            ),
          ),

          const SizedBox(
            height: 50,
          ),
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: MyThemeColors.grayBackground,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 28,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: HeaderAndSeeAll(
                    headerTitle: "Featured Product",
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                _fBuilder(),
                const SizedBox(
                  height: 36,
                ),
                const ShowNowCard(
                  cardTitle: "C02 - Cable Multifuntion",
                  cardColor: MyThemeColors.greenCardColor,
                  imgPath: "assets/images/p_1.png",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: HeaderAndSeeAll(
                    headerTitle: "Best Sellers",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _fBuilder(),
                const SizedBox(
                  height: 36,
                ),
                const ShowNowCard(
                  cardTitle: "Modular Headphone",
                  cardColor: MyThemeColors.primaryColor,
                  imgPath: "assets/images/p_3.png",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: HeaderAndSeeAll(
                    headerTitle: "New Arrivals",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _fBuilder(),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: HeaderAndSeeAll(
                    headerTitle: "Top Rated Product",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _fBuilder(),
                const SizedBox(
                  height: 36,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: HeaderAndSeeAll(
                    headerTitle: "Special Offers",
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _fBuilder(),
                const SizedBox(
                  height: 36,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: HeaderAndSeeAll(
              headerTitle: "Latest News",
              isSeeAllVis: false,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          // can add dynamic news later. this is just for static news

          // LatestNewsCard(
          //   title: newsList[0].title,
          //   subTitle: newsList[0].subTitle,
          //   // nDate: newsList[0].nDate,
          //   // imgPath: newsList[0].imgPath,
          //   onTapFunc: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => const NewsDetailPage(newsIndex: 0)));
          //   },
          // ),
          const Divider(
            indent: 25,
            endIndent: 25,
            thickness: .8,
            height: 20,
            color: MyThemeColors.grayText,
          ),

          // LatestNewsCard(
          //   title: newsList[1].title,
          //   subTitle: newsList[1].subTitle,
          //   // nDate: newsList[1].nDate,
          //   imgPath: newsList[1].imgPath,
          //   onTapFunc: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => const NewsDetailPage(newsIndex: 1)));
          //   },
          // ),

          const Divider(
            indent: 25,
            endIndent: 25,
            thickness: .8,
            height: 20,
            color: MyThemeColors.grayText,
          ),

          // LatestNewsCard(
          //   title: newsList[2].title,
          //   subTitle: newsList[2].subTitle,
          //   // nDate: newsList[2].nDate,
          //   imgPath: newsList[2].imgPath,
          //   onTapFunc: () {
          //     Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) => const NewsDetailPage(newsIndex: 2)));
          //   },
          // ),

          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NewsPage()));
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: MyThemeColors.textNaviColor)),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
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

          //
        ],
      ),
    );
  }

  Widget _fBuilder() {
    return BlocBuilder<ProductListCubit, ProductListState>(
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
      if (state.productList.isEmpty) {
        return const Center(
          child: Text("No product"),
        );
      }
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25),
        height: 280,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.productList.length,
          itemBuilder: (context, index) {
            ProductModel productItem = state.productList[index];

            return ProductCard(
              title: productItem.title.toString().length > 15
                  ? productItem.title.toString().substring(0, 15)
                  : productItem.title,
              price: productItem.price,
              imgPath: productItem.imagePath,
              iconBtnFunc: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Product Action",
                            style: MyTextTheme.latestNewsHeadterText),
                        actionsAlignment: MainAxisAlignment.start,
                        actions: [
                          GestureDetector(
                            onTap: () async {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .collection("wishList")
                                  .doc(productItem.id)
                                  .set({});

                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Added to wishlist"),
                                    backgroundColor:
                                        MyThemeColors.categoriesGreen),
                              );
                            },
                            child: Text(
                              "Add to wishlist",
                              style: MyTextTheme.latestNewsHeadterText,
                            ),
                          )
                        ],
                      );
                    });
              },
              onTapFunc: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductDetailPage(
                      productID: productItem.id,
                    ),
                  ),
                );
              },
              // rating: productItem["stock"],
              // numOfReviews: productItem["des"],
            );
          },
        ),
      );
    });
  }
}
