import 'package:e_commerce_app/core/common/place_order_button.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';

class LoginPlease extends StatelessWidget {
  final String buttonTitle;
  const LoginPlease({super.key, this.buttonTitle = 'Checkout'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          Image.asset("assets/images/hand.png"),
          const SizedBox(
            height: 12,
          ),
          Text("You need to log in first",
              textAlign: TextAlign.center,
              style: MyTextTheme.latestNewsHeadterText.copyWith(fontSize: 28)),
          Text("Please log in/register first to make a\n transaction",
              textAlign: TextAlign.center,
              style: MyTextTheme.latestNewsSubTitleText),
          const SizedBox(
            height: 24,
          ),
          CheckOutButton(
            buttonTitle: buttonTitle,
          )
        ],
      ),
    );
    ;
  }
}
