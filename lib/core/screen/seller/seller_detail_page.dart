import 'package:e_commerce_app/core/common/discount_product_card.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/services/firebase_db_services.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

class SellerDetailPage extends StatefulWidget {
  final String storeId;
  const SellerDetailPage({super.key, required this.storeId});

  @override
  State<SellerDetailPage> createState() => _SellerDetailPageState();
}

class _SellerDetailPageState extends State<SellerDetailPage> {
  dynamic storeInfo;

  dynamic products;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller Info",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: FirebaseDbServices().fetchStoreInfo(widget.storeId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                !snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(
                  color: MyThemeColors.primaryColor,
                ),
              );
            }

            storeInfo = snapshot.data;
            products = snapshot.data['products'];
            // print(snapshot.data['products'][1]);
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: SizedBox(
                              width: 45,
                              height: 45,
                              child: Image.network(storeInfo['imagePath'])),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              storeInfo['storeName'],
                              style: MyTextTheme.latestNewsHeadterText,
                              softWrap: true,
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
                                Icons.verified_user_rounded,
                                color: MyThemeColors.primaryColor,
                              )
                            ]),
                          ],
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          storeInfo['rating'].toString(),
                          style: MyTextTheme.loginPageLabel,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            storeInfo['address'],
                            style: MyTextTheme.loginPageLabel,
                            // maxLines: 1,
                            softWrap: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Follwers",
                              style: MyTextTheme.loginPageSubHeaderText,
                            ),
                            Text(
                              storeInfo['followers'].length.toString(),
                              style: MyTextTheme.productTitle,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Products",
                              style: MyTextTheme.loginPageSubHeaderText,
                            ),
                            Text(
                              products.length.toString(),
                              style: MyTextTheme.productTitle,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Join",
                              style: MyTextTheme.loginPageSubHeaderText,
                            ),
                            Text(
                              storeInfo['formattedDate'],
                              style: MyTextTheme.productTitle,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    decoration: const BoxDecoration(
                      color: MyThemeColors.grayBackground,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: products.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            // crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 280,
                          ),
                          itemBuilder: (context, index) {
                            var productItem = ProductModel.fromJSON(
                                products[index], products[index]!['id']);
                            // print(productItem);
                            return DiscountProductCard(
                                productItem: productItem);
                          }),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
