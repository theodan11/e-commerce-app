import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/common/app_bar_custom.dart';

import 'package:e_commerce_app/core/screen/home/home_page.dart';
import 'package:e_commerce_app/core/screen/login/login_page.dart';
import 'package:e_commerce_app/core/screen/order/order_page.dart';
import 'package:e_commerce_app/core/screen/user/user_profile_page.dart';
import 'package:e_commerce_app/core/screen/wishlist/wishlist_page.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final List<Widget> screenList = [
    const HomePage(),
    const WishlistPage(),
    const OrderPage(),
    // const CartListPage(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;
    return StreamBuilder(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }
        if (snapshot.hasData) {
          return FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .doc(auth.currentUser!.uid)
                  .get(),
              builder: (context, userSnapshot) {
                if (!userSnapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: MyThemeColors.primaryColor,
                    ),
                  );
                }
                Map<String, dynamic> user =
                    userSnapshot.data!.data() as Map<String, dynamic>;

                String fullname = user['fullname'];
                return Scaffold(
                  appBar: const AppBarCustom(),
                  body: screenList[_selectedIndex],
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _selectedIndex,
                    showUnselectedLabels: true,
                    iconSize: 22,
                    unselectedLabelStyle: MyTextTheme.bottomNavigationLabel,
                    selectedLabelStyle: MyTextTheme.bottomNavigationLabel,
                    onTap: (int index) {
                      if (index == 3) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const UserProfilePage()));
                      } else {
                        setState(() {
                          _selectedIndex = index;
                        });
                      }
                    },
                    items: [
                      const BottomNavigationBarItem(
                          icon: Icon(
                            Icons.home,
                          ),
                          label: "HOME"),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_outline_outlined),
                        label: "WISHLIST",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_bag_outlined),
                        label: "ORDER",
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.person),
                        label: fullname,
                      ),
                    ],
                  ),
                );
              });
        }
        return Scaffold(
          appBar: const AppBarCustom(),
          body: screenList[_selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            showUnselectedLabels: true,
            iconSize: 22,
            unselectedLabelStyle: MyTextTheme.bottomNavigationLabel,
            selectedLabelStyle: MyTextTheme.bottomNavigationLabel,
            onTap: (int index) {
              if (index == 3) {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: "HOME"),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline_outlined),
                label: "WISHLIST",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined),
                label: "ORDER",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "LOGIN",
              ),
            ],
          ),
        );
      },
    );
  }
}
