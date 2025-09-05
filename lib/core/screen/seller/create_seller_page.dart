import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/seller_cubit/seller_create_cubit.dart';
import 'package:e_commerce_app/core/cubit/seller_cubit/seller_create_state.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateSellerPage extends StatelessWidget {
  const CreateSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Store",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: BlocBuilder<SellerCreateCubit, SellerCreateState>(
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
                        "Pick an Image for Store",
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
                                  context.read<SellerCreateCubit>().resetForm();
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
                          context.read<SellerCreateCubit>().addImagePath(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Title",
                        style: MyTextTheme.loginPageLabel,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                        value: state.storeName,
                        hintText: "News title",
                        onChanged: (value) {
                          context.read<SellerCreateCubit>().addTitle(value);
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
                        // textEditingController: newsBodyController,
                        value: state.address,
                        maxLine: 5,
                        hintText: "Store Adrress",
                        onChanged: (value) {
                          context.read<SellerCreateCubit>().addAdrress(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: state.storeName != '' &&
                                state.address != '' &&
                                state.imagePath != ''
                            ? () async {
                                try {
                                  await context
                                      .read<SellerCreateCubit>()
                                      .uploadToCloud();

                                  if (state.isSuccess) {
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Store created successfully"),
                                        backgroundColor:
                                            Color.fromARGB(255, 10, 207, 66),
                                      ),
                                    );
                                    // ignore: use_build_context_synchronously
                                    context
                                        .read<SellerCreateCubit>()
                                        .resetForm();

                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context).pop();
                                    // ignore: use_build_context_synchronously
                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => const NewsPage(),
                                    //   ),
                                    // );
                                  }

                                  // ignore: use_build_context_synchronously

                                  // ignore: use_build_context_synchronously
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  // context
                                  //     .read<SellerCreateCubit>()
                                  //     .loadingSuccess();
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
                            color: state.storeName.isNotEmpty &&
                                    state.address.isNotEmpty &&
                                    state.imagePath.isNotEmpty
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
                                    "Publish News",
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
