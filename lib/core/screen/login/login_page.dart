import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/theme/my_text_theme.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController emailOrPhoneController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
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
                icon: Icons.remove_red_eye_outlined,
                isObscure: true,
              ),
              const SizedBox(
                height: 70,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyThemeColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: MyTextTheme.searchHintText.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Forgot Password",
                    style: MyTextTheme.productTitle,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text("Sign Up",
                        style: MyTextTheme.productTitle
                            .copyWith(color: MyThemeColors.primaryColor)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
