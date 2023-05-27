class RecommendWebtoonModel {
  final String title, thumb, id;

  RecommendWebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}