import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/core/cubit/product_cubit/product_state.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_model.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserUpdateProduct extends StatefulWidget {
  final ProductModel product;
  const UserUpdateProduct({super.key, required this.product});

  @override
  State<UserUpdateProduct> createState() => _UserUpdateProductState();
}

class _UserUpdateProductState extends State<UserUpdateProduct> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().updateAll(
        widget.product.title,
        widget.product.imagePath,
        widget.product.desc,
        widget.product.price,
        widget.product.stock,
        widget.product.originalPrice,
        widget.product.isDiscount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Product",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 30),
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
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) =>
                    previous.imagePath != current.imagePath,
                builder: (context, state) {
                  return Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) =>
                    previous.imagePath != current.imagePath,
                builder: (context, state) {
                  return MyTextField(
                    value: state.imagePath,
                    hintText: "Image link",
                    onChanged: (value) {
                      context.read<ProductCubit>().updateImagePath(value);
                    },
                  );
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
                height: 4,
              ),
              Text(
                widget.product.title,
                style: MyTextTheme.productUpdateOriginal,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) =>
                    previous.title != current.title,
                builder: (context, state) {
                  return MyTextField(
                    value: state.title,
                    hintText: "Product name",
                    onChanged: (value) {
                      context.read<ProductCubit>().updateTitle(value);
                    },
                  );
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
                height: 4,
              ),
              Text(
                widget.product.price.toString(),
                style: MyTextTheme.productUpdateOriginal,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) =>
                    previous.price != current.price,
                builder: (context, state) {
                  return MyTextField(
                    value: state.price.toString(),
                    hintText: "Product Price",
                    isNumber: TextInputType.number,
                    onChanged: (value) {
                      final parse = double.tryParse(value);
                      if (parse != null) {
                        context.read<ProductCubit>().updatePrice(parse);
                      }
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Special Offer",
                  style: MyTextTheme.loginPageLabel,
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocBuilder<ProductCubit, ProductState>(
                  buildWhen: (previous, current) =>
                      previous.isDiscount != current.isDiscount,
                  builder: (context, state) {
                    return Checkbox(
                        value: state.isDiscount,
                        focusColor: MyThemeColors.primaryColor,
                        side:
                            const BorderSide(color: MyThemeColors.primaryColor),
                        onChanged: (value) {
                          context.read<ProductCubit>().updateIsDiscount(value!);
                        });
                  },
                )
              ]),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Original Price",
                style: MyTextTheme.loginPageLabel,
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                widget.product.originalPrice.toString(),
                style: MyTextTheme.productUpdateOriginal,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) =>
                    previous.originalPrice != current.originalPrice,
                builder: (context, state) {
                  return MyTextField(
                    value: state.originalPrice.toString(),
                    hintText: "Product Original Price",
                    isNumber: TextInputType.number,
                    onChanged: (value) {
                      final parse = double.parse(value);
                      context.read<ProductCubit>().updateOriginalPrice(parse);
                    },
                  );
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
                height: 4,
              ),
              Text(
                widget.product.stock.toString(),
                style: MyTextTheme.productUpdateOriginal,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) =>
                    previous.stock != current.stock,
                builder: (context, state) {
                  return MyTextField(
                    value: state.stock.toString(),
                    hintText: "Product stock",
                    isNumber: TextInputType.number,
                    onChanged: (value) {
                      context
                          .read<ProductCubit>()
                          .updateStock(int.parse(value));
                    },
                  );
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
                height: 4,
              ),
              Text(
                widget.product.desc,
                style: MyTextTheme.productUpdateOriginal,
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductCubit, ProductState>(
                buildWhen: (previous, current) => previous.desc != current.desc,
                builder: (context, state) {
                  return MyTextField(
                    value: state.desc,
                    maxLine: 5,
                    hintText: "Product description...",
                    onChanged: (value) {
                      context.read<ProductCubit>().updateDesc(value);
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: state.title != widget.product.title ||
                            state.desc != widget.product.desc ||
                            state.imagePath != widget.product.imagePath ||
                            state.originalPrice !=
                                widget.product.originalPrice ||
                            state.price != widget.product.price ||
                            state.stock != widget.product.stock
                        ? () {
                            try {
                              context.read<ProductCubit>().loadingInProgress();

                              // if (widget.product.isDiscount ==
                              //     state.isDiscount) {}

                              context
                                  .read<ProductCubit>()
                                  .updateProduct(widget.product.id);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Product updated successfully"),
                                  backgroundColor:
                                      Color.fromARGB(255, 10, 207, 66),
                                ),
                              );

                              context.read<ProductCubit>().resetProductForm();

                              Navigator.of(context).pop();
                            } catch (e) {
                              context.read<ProductCubit>().loadingSuccess();
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
                        color: state.title!.isNotEmpty && state.desc!.isNotEmpty
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
                  );
                },
              )
            ],
          ),
        ),
      ),
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
