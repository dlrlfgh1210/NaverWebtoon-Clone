import 'dart:convert';

import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "https://korea-webtoon-api.herokuapp.com";
  static String todayWebtoon = "?service=kakao&updateDay=wed";

  static Future<List<TodayWebtoonModel>> getTodayWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl/$todayWebtoon');
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
}
