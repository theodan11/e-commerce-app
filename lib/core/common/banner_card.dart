import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
        child: SizedBox(
          width: 315,
          height: 150,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "assets/images/b_1.png",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                  ),
                  height: 150,
                  width: 190,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 34),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Shipping Costs During PPKM!",
                          style: MyTextTheme.appBarTitle
                              .copyWith(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Period May - August 2021",
                          style: MyTextTheme.bottomNavigationLabel.copyWith(
                              fontWeight: FontWeight.w400, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
