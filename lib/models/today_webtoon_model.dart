class TodayWebtoonModel {
  final String title, author, img, url;
  final int webtoonId;

  TodayWebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        img = json['img'],
        url = json['url'],
        webtoonId = json['webtoonId'];
}
