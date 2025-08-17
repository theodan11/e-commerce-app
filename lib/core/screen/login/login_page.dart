import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/login_form_cubit/login_form_cubit.dart';
import 'package:e_commerce_app/core/cubit/login_form_cubit/login_form_state.dart';
import 'package:e_commerce_app/core/screen/registration/registration_page.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/theme/my_text_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => LoginFormCubit(),
        child: BlocBuilder<LoginFormCubit, LoginFormState>(
          builder: (context, state) => SingleChildScrollView(
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
                    value: state.emailOrPhone,
                    hintText: "Enter you Email Addresss/ Phone Number",
                    onChanged: (value) {
                      context.read<LoginFormCubit>().updateEmailOrPhone(value);
                    },
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
                    value: state.password,
                    hintText: "Enter your Account Password",
                    onChanged: (value) {
                      context.read<LoginFormCubit>().updatePassword(value);
                    },
                    icon: Icons.remove_red_eye_outlined,
                    isObscure: state.isObscure,
                    iconBtnFunc: () =>
                        context.read<LoginFormCubit>().updateIsObscure(),
                  ),
                  const SizedBox(
                    height: 70,
                  ),
                  GestureDetector(
                    onTap: state.isValid
                        ? () {
                            context.read<LoginFormCubit>().submitForm();
                          }
                        : null,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: state.isValid
                            ? MyThemeColors.primaryColor
                            : MyThemeColors.grayText,
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
                  const SizedBox(
                    height: 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Forgot Password",
                          style: MyTextTheme.productTitle,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const RegistrationPage()));
                        },
                        child: Text(
                          "Sign Up",
                          style: MyTextTheme.productTitle
                              .copyWith(color: MyThemeColors.primaryColor),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
