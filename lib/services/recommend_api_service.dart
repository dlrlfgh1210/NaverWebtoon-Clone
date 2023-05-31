import 'dart:convert';

import 'package:naverwebtoon_clone/models/recommend_detail_model.dart';
import 'package:naverwebtoon_clone/models/recommend_episode_model.dart';
import 'package:naverwebtoon_clone/models/recommend_webtoon_model.dart';
import 'package:http/http.dart' as http;
import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';

class RecommendApiService {
  static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String recommend = "today";
 static const String kakaoRecommend = 'https://korea-webtoon-api.herokuapp.com/?perPage=30&service=kakao&updateDay=wed';

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

  static Future<List<TodayWebtoonModel>> getRecommendKakaoToons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$kakaoRecommend');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      final webtoons = json['webtoons'];
      for (var webtoon in webtoons) {
        todayInstances.add(TodayWebtoonModel.fromJson(webtoon));
      }
      return todayInstances;
    }
    throw Error();
  }

  static Future<RecommendDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseUrl/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = jsonDecode(response.body);
      return RecommendDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<RecommendEpisodeModel>> getLatestEpisodesById(String id) async {
    List<RecommendEpisodeModel> episodesInstances = [];
    final url = Uri.parse("$baseUrl/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = jsonDecode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(RecommendEpisodeModel.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}