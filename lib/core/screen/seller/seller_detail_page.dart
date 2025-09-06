import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/common/add_to_cart_button.dart';
import 'package:e_commerce_app/core/common/product_card.dart';
import 'package:e_commerce_app/core/screen/login/login_page.dart';
import 'package:e_commerce_app/core/screen/product/product_detail_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SellerDetailPage extends StatefulWidget {
  final String storeId;
  const SellerDetailPage({super.key, required this.storeId});

  @override
  State<SellerDetailPage> createState() => _SellerDetailPageState();
}

class _SellerDetailPageState extends State<SellerDetailPage> {
  dynamic storeInfo;

  dynamic products;

  Future<dynamic> fetchProduct() async {
    try {
      var productsSnapshot = await FirebaseFirestore.instance
          .collection("products")
          .where("storeId", isEqualTo: widget.storeId)
          .get();
      var products = productsSnapshot.docs;
      return products;
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  Future<dynamic> fetchStoreInfo() async {
    try {
      DocumentSnapshot storeSnapshot = await FirebaseFirestore.instance
          .collection("store")
          .doc(widget.storeId)
          .get();
      storeInfo = storeSnapshot.data() as Map<String, dynamic>;
      Timestamp createdAt = storeInfo['createdAt'] as Timestamp;
      DateTime date = createdAt.toDate();

      String fomattedDate = DateFormat("MMM dd yyyy").format(date);
      storeInfo['formattedDate'] = fomattedDate;
      var products = await fetchProduct();
      storeInfo['products'] = products;
      return storeInfo;
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seller Info",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchStoreInfo(),
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
            return Column(
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
                      Text(
                        storeInfo['address'],
                        style: MyTextTheme.loginPageLabel,
                        // maxLines: 1,
                        softWrap: true,
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
                          mainAxisExtent: 300,
                        ),
                        itemBuilder: (context, index) {
                          var productItem = products[index];
                          return ProductCard(
                              title: productItem['name'],
                              imgPath: productItem['imagePath'],
                              price: productItem['price'],
                              onTapFunc: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(
                                      productID: productItem.id,
                                    ),
                                  ),
                                );
                              },
                              iconBtnFunc: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Product Action",
                                            style: MyTextTheme
                                                .latestNewsHeadterText),
                                        actionsAlignment:
                                            MainAxisAlignment.start,
                                        actions: [
                                          Column(
                                            children: [
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const Divider(
                                                indent: 25,
                                                endIndent: 25,
                                                thickness: .8,
                                                height: 20,
                                                color: MyThemeColors.grayText,
                                              ),
                                              const SizedBox(
                                                height: 18,
                                              ),
                                              (FirebaseAuth.instance
                                                          .currentUser ==
                                                      null)
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();

                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const LoginPage()));
                                                      },
                                                      child: Text(
                                                        "Add to wishlist",
                                                        style: MyTextTheme
                                                            .latestNewsHeadterText,
                                                      ),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid)
                                                            .collection(
                                                                "wishList")
                                                            .doc(productItem.id)
                                                            .set({});

                                                        // ignore: use_build_context_synchronously
                                                        Navigator.of(context)
                                                            .pop();
                                                        // ignore: use_build_context_synchronously
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "Added to wishlist"),
                                                              backgroundColor:
                                                                  MyThemeColors
                                                                      .categoriesGreen),
                                                        );
                                                      },
                                                      child: Text(
                                                        "Add to wishlist",
                                                        style: MyTextTheme
                                                            .latestNewsHeadterText,
                                                      ),
                                                    ),
                                              const SizedBox(
                                                height: 18,
                                              ),
                                              const Divider(
                                                indent: 25,
                                                endIndent: 25,
                                                thickness: .8,
                                                height: 20,
                                                color: MyThemeColors.grayText,
                                              ),
                                              const SizedBox(
                                                height: 18,
                                              ),
                                              AddToCartButton(
                                                productItem: productItem,
                                              )
                                            ],
                                          )
                                        ],
                                      );
                                    });
                              });
                        }),
                  ),
                )
              ],
            );
          }),
    );
  }
}
