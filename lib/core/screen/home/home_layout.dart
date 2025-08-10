import 'package:e_commerce_app/core/screen/home/home_page.dart';
import 'package:e_commerce_app/core/screen/login/login_page.dart';
import 'package:e_commerce_app/core/screen/order/order_page.dart';
import 'package:e_commerce_app/core/screen/wishlist/wishlist_page.dart';
import 'package:e_commerce_app/core/theme/my_text_theme.dart';

import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  final List<Widget> screenList = [
    HomePage(),
    const WishlistPage(),
    const OrderPage(),
    const LoginPage(),
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mega Mall",
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
      body: screenList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        iconSize: 22,
        unselectedLabelStyle: MyTextTheme.bottomNavigationLabel,
        selectedLabelStyle: MyTextTheme.bottomNavigationLabel,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
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
  }
}
