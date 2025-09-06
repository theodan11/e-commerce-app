import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

class SellerDetailPage extends StatelessWidget {
  final String storeId;
  SellerDetailPage({super.key, required this.storeId});
  dynamic storeInfo;

  Future<dynamic>? fetchStoreInfo() async {
    try {
      DocumentSnapshot storeSnapshot = await FirebaseFirestore.instance
          .collection("store")
          .doc(storeId)
          .get();
      storeInfo = storeSnapshot.data() as Map<String, dynamic>;
      return storeInfo;
    } on FirebaseException catch (e) {
      print(e.message);
      return e.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Store",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: fetchStoreInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: MyThemeColors.primaryColor,
                ),
              );
            }

            storeInfo = snapshot.data;

            return Column(
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: SizedBox(
                          width: 45,
                          height: 45,
                          child: Image.network(storeInfo['imagePath'])),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          storeInfo['storeName'],
                          style: MyTextTheme.latestNewsHeadterText,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(children: [
                          Text(
                            "Official Store",
                            style: MyTextTheme.latestNewsHeadterText,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.verified_user_rounded,
                            color: MyThemeColors.primaryColor,
                          )
                        ]),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.chevron_right_rounded)
                  ],
                ),
              ],
            );
          }),
    );
  }
}
