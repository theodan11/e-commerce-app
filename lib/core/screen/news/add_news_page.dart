import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/news_cubit/add_news_cubit.dart';
import 'package:e_commerce_app/core/cubit/news_cubit/add_news_state.dart';
import 'package:e_commerce_app/core/screen/news/news_page.dart';

import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewsPage extends StatelessWidget {
  const AddNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add News",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: BlocBuilder<AddNewsCubit, AddNewsState>(
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
                                  context.read<AddNewsCubit>().clearimage();
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
                          context.read<AddNewsCubit>().updateImagePath(value);
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
                        value: state.title,
                        hintText: "News title",
                        onChanged: (value) {
                          context.read<AddNewsCubit>().updateTitle(value);
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
                        value: state.title,
                        maxLine: 5,
                        hintText: "News body",
                        onChanged: (value) {
                          context.read<AddNewsCubit>().updateDesc(value);
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
                                      .read<AddNewsCubit>()
                                      .loadingInProgress();

                                  await context
                                      .read<AddNewsCubit>()
                                      .uploadToCloud();

                                  // ignore: use_build_context_synchronously
                                  context.read<AddNewsCubit>().loadingSuccess();

                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("News added successfully"),
                                      backgroundColor:
                                          Color.fromARGB(255, 10, 207, 66),
                                    ),
                                  );

                                  // ignore: use_build_context_synchronously
                                  context.read<AddNewsCubit>().resetForm();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const NewsPage(),
                                    ),
                                  );
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  context.read<AddNewsCubit>().loadingSuccess();
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
