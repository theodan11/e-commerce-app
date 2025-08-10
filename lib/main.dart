import 'package:e_commerce_app/core/screen/home/home_layout.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            const ColorScheme.light(primary: MyThemeColors.primaryColor),
        useMaterial3: true,
      ),
      home: HomeLayout(),
    );
  }
}
