import 'package:e_commerce_app/core/cubit/order_cubit/order_model.dart';
import 'package:e_commerce_app/core/utility/theme/my_text_theme.dart';
import 'package:e_commerce_app/core/utility/theme/my_theme_colors.dart';
import 'package:flutter/material.dart';

class OrderSinglePage extends StatelessWidget {
  final OrderModel order;
  const OrderSinglePage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order",
            style: MyTextTheme.appBarTitle.copyWith(color: Colors.black87)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order ID: ${order.orderId}",
                style: MyTextTheme.latestNewsHeadterText,
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Order Status:",
                      style: MyTextTheme.latestNewsSubTitleText),
                  Text(" ${order.status}",
                      style: TextStyle(
                        color: order.status == 'PENDING'
                            ? MyThemeColors.primaryColor
                            : order.status == "CANCELED"
                                ? MyThemeColors.productPriceColor
                                : MyThemeColors.greenCardColor,
                      )),
                ],
              ),
              const Divider(
                height: 60,
                color: MyThemeColors.grayText,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Product Name",
                    style: MyTextTheme.latestNewsHeadterText,
                  ),
                  const Spacer(),
                  Text(
                    "Quantity",
                    style: MyTextTheme.latestNewsHeadterText,
                  ),
                  const SizedBox(
                    width: 6,
                  ),
                  Text(
                    "Price",
                    style: MyTextTheme.latestNewsHeadterText,
                  )
                ],
              ),
              const Divider(
                height: 40,
                color: MyThemeColors.grayText,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.52,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 14,
                        ),
                    itemCount: order.items.length,
                    itemBuilder: (context, index) {
                      var orderItem = order.items[index];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 200),
                            child: Flexible(
                              child: Text(
                                orderItem["product"]["productTitle"],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            "x ${orderItem["quantity"].toString()}",
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "৳ ${orderItem["product"]["productPrice"].toString()} tk",
                          ),
                        ],
                      );
                    }),
              ),
              const Divider(
                color: MyThemeColors.grayText,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Price",
                    style: MyTextTheme.headerTextStyle,
                  ),
                  Text(
                    "৳ ${order.totalPrice.toString()} tk",
                    style: MyTextTheme.headerTextStyle,
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
