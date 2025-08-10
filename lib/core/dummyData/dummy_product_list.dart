import 'package:e_commerce_app/core/dummyData/product.dart';

class DummyProducts {
  DummyProducts._();
  static final List<Product> productList = [
    Product(
      title: "TMA-2 HD Wireless",
      price: 1500000,
      img: 'assets/images/p_1.png',
      rating: 4.6,
      numOfReviews: 86,
    ),
    Product(
      title: "TMA-2 HD Wireless",
      price: 1300000,
      img: 'assets/images/p_2.png',
      rating: 4.6,
      numOfReviews: 86,
    ),
    Product(
      title: "TMA-2 HD Wireless",
      price: 1505000,
      img: 'assets/images/p_3.png',
      rating: 4.6,
      numOfReviews: 86,
    ),
  ];

  static final List<Product> productDiscountList = [
    Product(
      title: "TMA-2 HD Wireless",
      price: 1500000,
      prevOriginalPrice: 1800000,
      img: 'assets/images/p_3.png',
      rating: 4.6,
      numOfReviews: 86,
    ),
    Product(
      title: "TMA-2 HD Wireless",
      price: 1300000,
      prevOriginalPrice: 1800000,
      img: 'assets/images/p_2.png',
      rating: 4.6,
      numOfReviews: 86,
    ),
    Product(
      title: "TMA-2 HD Wireless",
      price: 1505000,
      prevOriginalPrice: 1800000,
      img: 'assets/images/p_1.png',
      rating: 4.6,
      numOfReviews: 86,
    ),
  ];
}
