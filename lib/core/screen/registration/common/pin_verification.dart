import 'package:e_commerce_app/core/common/header_and_see_all.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';

class PinVerification extends StatelessWidget {
  final String emailOrPhone;
  final Widget nextPage;
  const PinVerification(
      {super.key, required this.emailOrPhone, required this.nextPage});

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
                "Verification",
                style: MyTextTheme.loginPageHeaderText,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "We have sent a verification code to\n$emailOrPhone Change?",
                style: MyTextTheme.loginPageSubHeaderText,
              ),
              const SizedBox(
                height: 72,
              ),
              const HeaderAndSeeAll(
                headerTitle: "Verfication Code",
                btnTitle: "Re-send Code",
              ),
              const SizedBox(
                height: 20,
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Pinput(
              //     onCompleted: (pin) => Navigator.of(context)
              //         .push(MaterialPageRoute(builder: (context) => nextPage)),
              //   ),
              // ),
              const SizedBox(
                height: 120,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyThemeColors.primaryColor),
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
            ],
          ),
        ),
      ),
    );
  }
}
