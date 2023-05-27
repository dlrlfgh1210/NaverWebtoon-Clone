import 'dart:convert';

import 'package:naverwebtoon_clone/models/recommend_webtoon_model.dart';
import 'package:http/http.dart' as http;

class RecommendApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String recommend = "today";

  static Future<List<RecommendWebtoonModel>> getRecommendToons() async {
    List<RecommendWebtoonModel> recommendInstance = [];
    final url = Uri.parse('$baseUrl/$recommend');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final instance = RecommendWebtoonModel.fromJson(webtoon);
        recommendInstance.add(instance);
      }
      return recommendInstance;
    }
    throw Error();
  }
}