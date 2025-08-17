import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_cubit.dart';
import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_state.dart';
import 'package:e_commerce_app/core/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/theme/my_text_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationNamePass extends StatelessWidget {
  const RegistrationNamePass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SignUpFormCubit(),
        child: BlocBuilder<SignUpFormCubit, SignUpFormState>(
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
                    "Profile & Password",
                    style: MyTextTheme.loginPageHeaderText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Complete the following last data to log in to the\nMega Mall application",
                    style: MyTextTheme.loginPageSubHeaderText,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Full Name",
                    style: MyTextTheme.loginPageLabel,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyTextField(
                    value: state.fullName,
                    hintText: "Enter full name",
                    onChanged: (value) {
                      context.read<SignUpFormCubit>().updateFullName(value);
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
                    hintText: "Enter password",
                    isObscure: state.isObscure,
                    onChanged: (value) {
                      context.read<SignUpFormCubit>().updatePassword(value);
                    },
                    icon: Icons.remove_red_eye_outlined,
                    iconBtnFunc: () {
                      context.read<SignUpFormCubit>().updateIsObscure();
                    },
                  ),
                  const SizedBox(
                    height: 114,
                  ),
                  GestureDetector(
                    onTap: state.isEmailValid ? () {} : null,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: state.isProfileValid
                            ? MyThemeColors.primaryColor
                            : MyThemeColors.grayText,
                      ),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: MyTextTheme.searchHintText.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an Account?",
                        style: MyTextTheme.loginPageLabel,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Sign In",
                          style: MyTextTheme.productTitle
                              .copyWith(color: MyThemeColors.primaryColor),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
