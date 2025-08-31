import 'package:e_commerce_app/core/common/text_field.dart';
import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_cubit.dart';
import 'package:e_commerce_app/core/cubit/sign_up_form_cubit/sign_up_form_state.dart';

import 'package:e_commerce_app/core/screen/home/home_layout.dart';

import 'package:e_commerce_app/core/services/firebase_auth_service.dart';
import 'package:e_commerce_app/core/services/firebase_db_services.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationNamePass extends StatelessWidget {
  const RegistrationNamePass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SignUpFormCubit, SignUpFormState>(
        // listener: (context, state) {},

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
                    // print("Full name: ${state.fullName}");
                    // print("Password: ${state.password}");
                    // print("isProfileValid: ${state.isProfileValid}");
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
                    // print("Full name: ${state.fullName}");
                    // print("Password: ${state.password}");
                    // print("isProfileValid: ${state.isProfileValid}");
                    context.read<SignUpFormCubit>().updatePassword(value);
                  },
                  icon: Icons.remove_red_eye_outlined,
                  iconBtnFunc: () {
                    context.read<SignUpFormCubit>().updateIsObscure();
                  },
                ),
                const SizedBox(
                  height: 80,
                ),
                GestureDetector(
                  onTap: state.isProfileValid
                      ? () async {
                          // print(state.emailOrPhone);
                          // print("Full name: ${state.fullName}");
                          // print("Password: ${state.password}");
                          // print(state.isProfileValid);
                          context.read<SignUpFormCubit>().loadingInProgress();
                          try {
                            var userCred = await FirebaseAuthService()
                                .signUP(state.emailOrPhone!, state.password!);

                            // print(userCred!.user!);

                            await FirebaseDbServices()
                                .saveUserToDB(userCred!, state.fullName!);
                            // ignore: use_build_context_synchronously
                            context.read<SignUpFormCubit>().loadingSuccess();
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Registration Successful"),
                              backgroundColor: Color.fromARGB(255, 10, 207, 66),
                            ));
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const HomeLayout()));
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: MyThemeColors.productPriceColor,
                            ));
                            // ignore: use_build_context_synchronously
                            context.read<SignUpFormCubit>().loadingSuccess();
                          }

                          // print("presssed");
                          // ignore: use_build_context_synchronously
                        }
                      : null,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: state.isProfileValid
                          ? MyThemeColors.primaryColor
                          : MyThemeColors.grayText,
                    ),
                    child: state.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Center(
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
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
