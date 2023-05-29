class RecommendEpisodeModel {
  final String id, title, rating, date, thumb;

  RecommendEpisodeModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        thumb = json['thumb'],
        date = json['date'];
}
