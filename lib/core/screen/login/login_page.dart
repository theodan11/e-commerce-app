import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/theme/my_text_theme.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 72,
            ),
            Text(
              "Welcome back to \nMega Mall",
              style: MyTextTheme.loginPageHeaderText,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Please enter your login information",
              style: MyTextTheme.loginPageSubHeaderText,
            ),
            const SizedBox(
              height: 50,
            ),
            Text(
              "Email/ Phone",
              style: MyTextTheme.loginPageLabel,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              textEditingController: emailOrPhoneController,
              hintText: "Enter you Email Addresss/ Phone Number",
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              "Password",
              style: MyTextTheme.loginPageLabel,
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              textEditingController: passwordController,
              hintText: "Enter your Account Password",
              icon: Icons.remove_red_eye,
            ),
          ],
        ),
      ),
    );
  }
}
