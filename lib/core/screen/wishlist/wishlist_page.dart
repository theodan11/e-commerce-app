import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/screen/product/product_detail_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/services/firebase_db_services.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyThemeColors.primaryColor,
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text("login please"),
          );
        }

        return FutureBuilder(
            future: FirebaseDbServices().fetchWishList(),
            builder: (context, wishSnapshot) {
              if (wishSnapshot.connectionState == ConnectionState.waiting ||
                  wishSnapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: MyThemeColors.primaryColor,
                  ),
                );
              }

              var wishListarr = wishSnapshot.data ?? [];
              if (wishListarr.isEmpty) {
                return Center(
                  child: Text(
                    "Your wishlist is empty",
                    style: MyTextTheme.latestNewsHeadterText,
                  ),
                );
              }
              // print(wishListarr);
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 30),
                  child: SizedBox(
                    // height: 500,
                    child: ListView.builder(
                      itemCount: wishListarr.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> product = wishListarr[index];

                        return Dismissible(
                          key: ValueKey(product["id"]),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            FirebaseDbServices().deleteWishList(
                                FirebaseAuth.instance.currentUser!.uid,
                                product["id"]);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Removed from wishlist"),
                                  backgroundColor:
                                      MyThemeColors.categoriesGreen),
                            );
                          },
                          child: Card(
                              child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    productID: product["id"],
                                  ),
                                ),
                              );
                            },
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 150, maxWidth: 550),
                              child: FittedBox(
                                child: SizedBox(
                                  width: 325,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 225,
                                        child: Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                product['name'],
                                                style: MyTextTheme
                                                    .latestNewsHeadterText,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: Image.network(
                                            product['imagePath'],
                                            fit: BoxFit.cover,
                                            alignment: Alignment.topLeft,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )),
                        );
                      },
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
