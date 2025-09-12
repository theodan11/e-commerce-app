import 'package:e_commerce_app/core/screen/login/login_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckOutButton extends StatelessWidget {
  final String buttonTitle;
  const CheckOutButton({super.key, this.buttonTitle = "Checkout"});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FirebaseAuth.instance.currentUser == null) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: MyThemeColors.primaryColor),
        child: Center(
          child: Text(
            buttonTitle,
            style: MyTextTheme.searchHintText.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
