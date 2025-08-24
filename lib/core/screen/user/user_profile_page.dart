import 'package:e_commerce_app/core/common/custom_profile_button.dart';
import 'package:e_commerce_app/core/screen/home/home_layout.dart';
import 'package:e_commerce_app/core/screen/news/add_news_page.dart';
import 'package:e_commerce_app/core/screen/product/add_product_page.dart';
import 'package:e_commerce_app/core/services/firebase_auth_service.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomProfileButton(
              onTapFunc: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddNewsPage()));
              },
              btnTitle: "Add News",
              icon: Icons.post_add_outlined,
              iconColor: MyThemeColors.primaryColor,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomProfileButton(
              onTapFunc: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddProductPage()));
              },
              btnTitle: "Add Product",
              icon: Icons.add,
              iconColor: MyThemeColors.primaryColor,
            ),
            const Spacer(),
            const Divider(
              color: MyThemeColors.grayText,
            ),
            const SizedBox(
              height: 24,
            ),
            CustomProfileButton(
              onTapFunc: () async {
                await FirebaseAuthService().signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeLayout()));
              },
              btnTitle: "Sign out",
              icon: Icons.logout,
              iconColor: MyThemeColors.productPriceColor,
            ),
          ],
        ),
      ),
    );
  }
}
