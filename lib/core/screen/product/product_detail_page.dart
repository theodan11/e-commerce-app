import 'package:e_commerce_app/core/common/header_and_see_all.dart';
import 'package:e_commerce_app/core/common/product_card.dart';
import 'package:e_commerce_app/core/dummyData/dummy_product_list.dart';
import 'package:e_commerce_app/core/dummyData/product.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Product> products = DummyProducts.productList;
    MoneyFormatter money = MoneyFormatter(amount: 1500000);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detail Product",
          style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 325,
                  height: 300,
                  child: Image.asset(
                    'assets/images/p_1.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "TMA-2HD Wireless",
                style: MyTextTheme.productDetailHeaderText,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "৳ ${money.output.nonSymbol}",
                style: MyTextTheme.productPrice.copyWith(fontSize: 16),
              ),
              const SizedBox(
                height: 13,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      size: 10,
                      color: MyThemeColors.ratingStarColor,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "4.6",
                      style: MyTextTheme.productBottomText,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      "86 Reviews",
                      style: MyTextTheme.productBottomText,
                    )
                  ],
                ),
                Text(
                  "Available: 250",
                  style: MyTextTheme.availableProductText,
                )
              ]),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                indent: 25,
                endIndent: 25,
                thickness: .8,
                height: 20,
                color: MyThemeColors.grayText,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                          width: 45,
                          height: 45,
                          child: Image.asset("assets/images/ln_2.png")),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Shop Larson Electronic",
                          style: MyTextTheme.latestNewsHeadterText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Text(
                            "Official Store",
                            style: MyTextTheme.latestNewsHeadterText,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.safety_check_rounded,
                            color: MyThemeColors.primaryColor,
                          )
                        ]),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right_rounded)
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                indent: 25,
                endIndent: 25,
                thickness: .8,
                height: 20,
                color: MyThemeColors.grayText,
              ),
              const SizedBox(
                height: 30,
              ),
              const HeaderAndSeeAll(
                headerTitle: "Description Product",
                isSeeAllVis: false,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.\n\nThe speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.  ",
                style: MyTextTheme.newsDescText,
              ),
              const SizedBox(
                height: 30,
              ),
              const Divider(
                indent: 25,
                endIndent: 25,
                thickness: .8,
                height: 20,
                color: MyThemeColors.grayText,
              ),
              HeaderAndSeeAll(
                headerTitle: "Reviews (86)",
                btnTitle: "4.6",
              ),
              GestureDetector(
                onTap: () {},
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
              ),
              const HeaderAndSeeAll(
                headerTitle: "Featured Product",
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                height: 280,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    Product productItem = products[index];

                    return ProductCard(
                      title: productItem.title,
                      price: productItem.price,
                      imgPath: productItem.img,
                      rating: productItem.rating,
                      numOfReviews: productItem.numOfReviews,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyThemeColors.productPriceColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Added to card",
                                  style: MyTextTheme.searchHintText.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                const Icon(
                                  Icons.favorite,
                                  color: Colors.white,
                                )
                              ]),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: MyThemeColors.primaryColor),
                        child: Center(
                          child: Text(
                            "Add to Cart",
                            style: MyTextTheme.searchHintText.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
