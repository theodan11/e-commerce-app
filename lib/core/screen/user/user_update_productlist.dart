import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/cubit/user_store_product_cubit/user_store_product_list_cubit.dart';
import 'package:e_commerce_app/core/cubit/user_store_product_cubit/user_store_product_list_state.dart';
import 'package:e_commerce_app/core/screen/user/user_update_product.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserUpdateProductlist extends StatefulWidget {
  const UserUpdateProductlist({super.key});

  @override
  State<UserUpdateProductlist> createState() => _UserUpdateProductlistState();
}

class _UserUpdateProductlistState extends State<UserUpdateProductlist> {
  @override
  initState() {
    super.initState();
    context.read<UserStoreProductListCubit>().fetchStoreInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Product",
          style: MyTextTheme.appBarTitle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
          const SizedBox(
            width: 25,
          )
        ],
      ),
      body: BlocConsumer<UserStoreProductListCubit, UserStoreProductListState>(
        listener: (context, state) {
          if (state.storeInfo["id"] != null) {
            context.read<UserStoreProductListCubit>().fetchProductWithStoreId();
          }
          if (state.storeInfo.isEmpty) {
            context.read<UserStoreProductListCubit>().fetchStoreInfo();
          }
        },
        builder: (context, state) {
          if (state.productList.isEmpty) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyThemeColors.primaryColor,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: ListView.separated(
                itemCount: state.productList.length,
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 8,
                  );
                },
                itemBuilder: (context, index) {
                  ProductModel product = state.productList[index];
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: MyThemeColors.primaryColor),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                product.title,
                                style: MyTextTheme.productTitle,
                                softWrap: true,
                                maxLines: 1,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        content: const Text("Are you sure?"),
                                        actions: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<
                                                            UserStoreProductListCubit>()
                                                        .deleteProduct(
                                                            product.id);
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(
                                                      const SnackBar(
                                                        content: Text(
                                                            "Product deleted successfully"),
                                                        backgroundColor:
                                                            Color.fromARGB(255,
                                                                10, 207, 66),
                                                      ),
                                                    );
                                                  },
                                                  child: Text("Delete",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .red.shade600)),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancel"),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                Icons.delete_forever_outlined,
                                color: Colors.red.shade500,
                                size: 24,
                              ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserUpdateProduct(
                                          product: product,
                                        )));
                              },
                              icon: Icon(
                                Icons.system_update_alt,
                                color: Colors.blue.shade500,
                                size: 24,
                              ),
                            )
                          ]));
                }),
          );
        },
      ),
    );
  }
}
