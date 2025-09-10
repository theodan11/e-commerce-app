import 'package:e_commerce_app/core/common/custom_profile_button.dart';
import 'package:e_commerce_app/core/screen/home/home_layout.dart';
import 'package:e_commerce_app/core/screen/product/add_product_page.dart';
import 'package:e_commerce_app/core/screen/seller/create_seller_page.dart';
import 'package:e_commerce_app/core/services/firebase_auth_service.dart';
import 'package:e_commerce_app/core/services/firebase_db_services.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

class UserSellerPage extends StatelessWidget {
  const UserSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Seller Dashboard",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (FirebaseDbServices().checkIfSeller() == false)
                  ? CustomProfileButton(
                      onTapFunc: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CreateSellerPage()));
                      },
                      btnTitle: "Update a product",
                      icon: Icons.update_outlined,
                      iconColor: MyThemeColors.primaryColor,
                    )
                  : CustomProfileButton(
                      onTapFunc: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CreateSellerPage()));
                      },
                      btnTitle: "Check products",
                      icon: Icons.add,
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

                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Sign out successful")));
                },
                btnTitle: "Sign out",
                icon: Icons.logout,
                iconColor: MyThemeColors.productPriceColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
