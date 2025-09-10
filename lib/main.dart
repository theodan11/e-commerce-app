import 'package:e_commerce_app/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:e_commerce_app/core/cubit/login_form_cubit/login_form_cubit.dart';
import 'package:e_commerce_app/core/cubit/news_cubit/add_news_cubit.dart';
import 'package:e_commerce_app/core/cubit/news_cubit/news_list_cubit.dart';
import 'package:e_commerce_app/core/cubit/product_cubit/product_cubit.dart';
import 'package:e_commerce_app/core/cubit/product_list_cubit/product_list_cubit.dart';
import 'package:e_commerce_app/core/cubit/review_cubit/review_create_cubit.dart';
import 'package:e_commerce_app/core/cubit/seller_cubit/seller_create_cubit.dart';

import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_cubit.dart';
import 'package:e_commerce_app/core/cubit/user_update_cubit/user_update_cubit.dart';
import 'package:e_commerce_app/core/screen/home/home_layout.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => LoginFormCubit()),
    BlocProvider(create: (_) => SignUpFormCubit()),
    BlocProvider(create: (_) => AddNewsCubit()),
    BlocProvider(create: (_) => ProductCubit()),
    BlocProvider(create: (_) => ProductListCubit()),
    BlocProvider(create: (_) => NewsListCubit()),
    BlocProvider(create: (_) => CartCubit()),
    BlocProvider(create: (_) => SellerCreateCubit()),
    BlocProvider(create: (_) => ReviewCreateCubit()),
    BlocProvider(create: (_) => UserUpdateCubit()),
  ], child: const MyApp()));
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
      home: const HomeLayout(),
    );
  }
}
