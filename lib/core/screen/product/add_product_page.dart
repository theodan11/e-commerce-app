import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/core/cubit/product_cubit/product_state.dart';
import 'package:e_commerce_app/core/screen/home/home_layout.dart';

import 'package:e_commerce_app/core/services/firebase_db_services.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 72,
                      ),
                      Text(
                        "Pick an Image",
                        style: MyTextTheme.loginPageLabel,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                color: MyThemeColors.grayText),
                            child: _imageDisplay(context, state),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                              onPressed: () {
                                if (state.imagePath != '') {
                                  // context.read<ProductCubit>().clearimage();
                                }
                              },
                              icon: const Icon(Icons.restart_alt_outlined))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        value: state.imagePath,
                        hintText: "Image link",
                        onChanged: (value) {
                          context.read<ProductCubit>().updateImagePath(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Name",
                        style: MyTextTheme.loginPageLabel,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        value: state.title,
                        hintText: "Product name",
                        onChanged: (value) {
                          context.read<ProductCubit>().updateTitle(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Price",
                        style: MyTextTheme.loginPageLabel,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        value: state.price.toString(),
                        hintText: "Product Price",
                        isNumber: TextInputType.number,
                        onChanged: (value) {
                          context
                              .read<ProductCubit>()
                              .updatePrice(double.parse(value));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Stock",
                        style: MyTextTheme.loginPageLabel,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        value: state.stock.toString(),
                        hintText: "Product stock",
                        isNumber: TextInputType.number,
                        onChanged: (value) {
                          context
                              .read<ProductCubit>()
                              .updateStock(int.parse(value));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Description",
                        style: MyTextTheme.loginPageLabel,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        value: state.desc,
                        maxLine: 5,
                        hintText: "Product description...",
                        onChanged: (value) {
                          context.read<ProductCubit>().updateDesc(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: state.title != '' && state.desc != ''
                            ? () async {
                                try {
                                  context
                                      .read<ProductCubit>()
                                      .loadingInProgress();

                                  await FirebaseDbServices().saveProductToCloud(
                                    state.title,
                                    state.imagePath,
                                    state.price,
                                    state.stock,
                                    state.desc,
                                  );

                                  // ignore: use_build_context_synchronously
                                  context.read<ProductCubit>().loadingSuccess();

                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text("Product added successfully"),
                                      backgroundColor:
                                          Color.fromARGB(255, 10, 207, 66),
                                    ),
                                  );

                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<ProductCubit>()
                                      .resetProductForm();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const HomeLayout(),
                                    ),
                                  );
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  context.read<ProductCubit>().loadingSuccess();
                                  // print(e);

                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      e.toString(),
                                    ),
                                    backgroundColor:
                                        MyThemeColors.productPriceColor,
                                  ));
                                }
                              }
                            : null,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: state.title!.isNotEmpty &&
                                    state.desc!.isNotEmpty
                                ? MyThemeColors.primaryColor
                                : MyThemeColors.grayText,
                          ),
                          child: state.isLoading && !state.isSuccess
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "Publish Product",
                                    style: MyTextTheme.searchHintText.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }

  Widget _imageDisplay(context, state) {
    return state.imagePath != ''
        ? Image.network(
            state.imagePath!,
            fit: BoxFit.cover,
          )
        : const Icon(
            Icons.add,
            size: 32,
            color: Colors.white,
          );
  }
}
