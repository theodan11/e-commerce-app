class NewsModel {
  final String title;
  final String desc;
  final String imagePath;
  final String userID;
  final String id;

  NewsModel(
      {required this.title,
      required this.desc,
      required this.imagePath,
      required this.userID,
      required this.id});



    factory NewsModel.fromJSON(Map<String, dynamic> json, String id){
      return NewsModel(
        title: json['title'] as String,
        desc: json['desc'] as String,
        imagePath: json['imagePath'] as String, 
        userID: json['userID'] as String, 
        id: id, 
      );
    }
}
