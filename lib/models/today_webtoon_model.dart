class TodayWebtoonModel {
  final String title, author, img;

  TodayWebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        img = json['img'];
}
