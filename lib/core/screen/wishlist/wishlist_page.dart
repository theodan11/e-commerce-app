import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: MyThemeColors.primaryColor,
            ),
          );
        }

        if (!snapshot.hasData) {
          return const Center(
            child: Text("login please"),
          );
        }

        return const Center(
          child: Text("wishlist"),
        );
      },
    );
  }
}
