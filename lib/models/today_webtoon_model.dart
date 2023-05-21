class TodayWebtoonModel {
  final String title, author, img, url, searchKeyword, service;
  final int webtoonId;

  TodayWebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        author = json['author'],
        img = json['img'],
        url = json['url'],
        searchKeyword = json['searchKeyword'],
        service = json['service'],
        webtoonId = json['webtoonId'];
}
