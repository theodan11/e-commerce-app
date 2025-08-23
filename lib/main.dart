import 'package:e_commerce_app/core/cubit/login_form_cubit/login_form_cubit.dart';
import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_cubit.dart';
import 'package:e_commerce_app/core/screen/home/home_layout.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';
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
    BlocProvider(create: (_) => SignUpFormCubit())
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
      home: HomeLayout(),
    );
  }
}
