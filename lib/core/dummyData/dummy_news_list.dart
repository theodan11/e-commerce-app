import 'package:e_commerce_app/core/dummyData/news.dart';

class DummyNewsList {
  DummyNewsList._();

  static final List<News> newsList = [
    const News(
      title: "Philosophy That Addresses Topics Such As Goodness",
      subTitle: "To keep it shiny, the motorcycle body...",
      nDate: "13 Jan 2021",
      imgPath: "assets/images/ln_1.png",
    ),
    const News(
      title:
          "Many inquiries outside of academia are philosophical in a broad sense.",
      subTitle: "In a broad sense, philosophy is about...",
      nDate: "13 Jan 2021",
      imgPath: "assets/images/ln_2.png",
    ),
    const News(
      title:
          "Tips for Maintaining Your Car's Body to Keep It from Looking Dull",
      subTitle: "To keep it shiny, the motorcycle body...",
      nDate: "13 Jan 2021",
      imgPath: "assets/images/ln_3.png",
    ),
  ];
}
