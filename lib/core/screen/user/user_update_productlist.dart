import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/cubit/user_store_product_cubit/user_store_product_list_cubit.dart';
import 'package:e_commerce_app/core/cubit/user_store_product_cubit/user_store_product_list_state.dart';
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
          // if (state.productList.isEmpty) {
          //   return const Text("No product");
          // }
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: MyThemeColors.primaryColor,
              ),
            );
          }
          return ListView.builder(
              itemCount: state.productList.length,
              itemBuilder: (context, index) {
                ProductModel product = state.productList[index];
                return ListTile(
                    leading: Text(product.title),
                    subtitle: Text(product.price.toString()));
              });
          // return ListView.builder(itemBuilder: (context, index) {
          //   ProductModel product = state.productList[index];
          // });
        },
      ),
    );
  }
}
