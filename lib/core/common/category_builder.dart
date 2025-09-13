import 'package:e_commerce_app/core/constant/category_of_item.dart';
import 'package:e_commerce_app/core/cubit/catogory_cubit/category_cubit.dart';
import 'package:e_commerce_app/core/cubit/catogory_cubit/category_state.dart';
import 'package:e_commerce_app/core/screen/category_page/category_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryBuilder extends StatelessWidget {
  final bool isNavigator;
  const CategoryBuilder({super.key, this.isNavigator = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: SizedBox(
        height: 80,
        child: ListView.builder(
            itemCount: CategoryItem.categoryList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Map<String, dynamic> categoryItem =
                  CategoryItem.categoryList[index];
              return BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      // print(categoryItem['lable']);
                      context
                          .read<CategoryCubit>()
                          .updateCategory(categoryItem['lable']);
                      if (isNavigator) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CategoryPage()));
                      }
                    },
                    child: SizedBox(
                      width: 80,
                      height: 76,
                      child: Column(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: categoryItem['bgColor'],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                categoryItem['imagePath'],
                                colorFilter: ColorFilter.mode(
                                    categoryItem['color'], BlendMode.srcIn),
                                width: 28,
                                height: 28,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(categoryItem['lable'],
                              style: MyTextTheme.productTitle)
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
