import 'package:e_commerce_app/core/common/category_builder.dart';
import 'package:e_commerce_app/core/common/discount_product_card.dart';
import 'package:e_commerce_app/core/cubit/catogory_cubit/category_cubit.dart';
import 'package:e_commerce_app/core/cubit/catogory_cubit/category_state.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_list_cubit.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_list_state.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    String category;
    return BlocBuilder<CategoryCubit, CategoryState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              state.category,
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
          body: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              const CategoryBuilder(
                isNavigator: false,
              ),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<ProductListCubit, ProductListState>(
                  builder: (context, productState) {
                List<ProductModel> filteredProducts;
                if (state.category != "All") {
                  filteredProducts = productState.productList.where((item) {
                    return item.category == state.category;
                  }).toList();
                } else {
                  filteredProducts = productState.productList;
                }

                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.66,
                    child: GridView.builder(
                        itemCount: filteredProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                mainAxisSpacing: 8,
                                mainAxisExtent: 280),
                        itemBuilder: (context, index) {
                          return DiscountProductCard(
                              productItem: filteredProducts[index]);
                        }),
                  ),
                );
              }),
            ],
          ));
    });
  }
}
