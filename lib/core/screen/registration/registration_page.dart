import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_cubit.dart';
import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_state.dart';

import 'package:e_commerce_app/core/screen/registration/registration_name_pass.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';

import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SignUpFormCubit, SignUpFormState>(
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
                  "Register Account",
                  style: MyTextTheme.loginPageHeaderText,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Enter Email/ Phone Number to register",
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
                    context
                        .read<SignUpFormCubit>()
                        .updateEmailOrPhone(value.trim());
                  },
                ),
                const SizedBox(
                  height: 114,
                ),
                GestureDetector(
                  onTap: state.isEmailValid
                      ? () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const RegistrationNamePass()));
                          // sendOTP(state.emailOrPhone!);
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => PinVerification(
                          //         emailOrPhone: state.emailOrPhone!,
                          //         nextPage: const RegistrationNamePass())));
                        }
                      : null,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: state.isEmailValid
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
    );
  }
}
