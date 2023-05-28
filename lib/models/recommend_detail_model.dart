import 'dart:convert';

class RecommendDetailModel {
  final String title, about, genre, age;

  RecommendDetailModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        about = json['about'],
        genre = json['genre'],
        age = json['age'];
}
