import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/review_cubit/review_create_cubit.dart';
import 'package:e_commerce_app/core/cubit/review_cubit/review_create_state.dart';
import 'package:e_commerce_app/core/screen/login/login_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteAReview extends StatelessWidget {
  final String productID;
  const WriteAReview({super.key, required this.productID});
  @override
  Widget build(BuildContext context) {
    // double rating = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Write a Review",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: BlocConsumer<ReviewCreateCubit, ReviewCreateState>(
          listener: (context, state) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Review added successfully"),
                  backgroundColor: Color.fromARGB(255, 10, 207, 66),
                ),
              );
              context.read<ReviewCreateCubit>().resetForm();
              Navigator.pop(context, true);
            }
          },
          builder: (context, state) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 30),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 72,
                        ),
                        Text(
                          "Review",
                          style: MyTextTheme.loginPageLabel,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          value: state.customerExperience,
                          hintText: "Experience",
                          maxLine: 3,
                          onChanged: (value) {
                            context
                                .read<ReviewCreateCubit>()
                                .updateCustomerExperience(value);
                            // print(state.customerExperience);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Rating",
                          style: MyTextTheme.loginPageLabel,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            (state.rating! < 1)
                                ? const Icon(
                                    Icons.star_border,
                                    size: 32,
                                    color: MyThemeColors.grayText,
                                  )
                                : const Icon(
                                    Icons.star_rate,
                                    size: 32,
                                    color: Colors.amber,
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            state.rating! < 2
                                ? const Icon(
                                    Icons.star_border,
                                    size: 32,
                                    color: MyThemeColors.grayText,
                                  )
                                : const Icon(
                                    Icons.star_rate,
                                    size: 32,
                                    color: Colors.amber,
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            state.rating! < 3
                                ? const Icon(
                                    Icons.star_border,
                                    size: 32,
                                    color: MyThemeColors.grayText,
                                  )
                                : const Icon(
                                    Icons.star_rate,
                                    size: 32,
                                    color: Colors.amber,
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            state.rating! < 4
                                ? const Icon(
                                    Icons.star_border,
                                    size: 32,
                                    color: MyThemeColors.grayText,
                                  )
                                : const Icon(
                                    Icons.star_rate,
                                    size: 32,
                                    color: Colors.amber,
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            state.rating! < 5
                                ? const Icon(
                                    Icons.star_border,
                                    size: 32,
                                    color: MyThemeColors.grayText,
                                  )
                                : const Icon(
                                    Icons.star_rate,
                                    size: 32,
                                    color: Colors.amber,
                                  ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Spacer(
                              flex: 1,
                            ),
                            Text(state.rating.toString())
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Slider(
                            divisions: 5,
                            value: (state.rating!).toDouble(),
                            max: 5,
                            activeColor: Colors.amber,
                            label: state.rating!.round().toString(),
                            min: 0,
                            onChanged: (value) {
                              context
                                  .read<ReviewCreateCubit>()
                                  .updateRating(value.toInt());

                              // print(state.rating);
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: state.customerExperience != ''
                              ? () {
                                  if (FirebaseAuth.instance.currentUser !=
                                      null) {
                                    context
                                        .read<ReviewCreateCubit>()
                                        .saveReview(productID);
                                  } else {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  }
                                }
                              : null,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: state.customerExperience!.isNotEmpty
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
                                      "Save your Review",
                                      style:
                                          MyTextTheme.searchHintText.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
    );
  }
}
