import 'dart:convert';

import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "https://korea-webtoon-api.herokuapp.com/?service=naver&updateDay=";
  static String MondayWebtoon = "mon";
  static String TuesdayWebtoon= "tue";
  static String WednesdayWebtoon= "wed";
  static String ThursdayWebtoon= "thu";
  static String FridayWebtoon= "fri";
  static String SaturdayWebtoon= "sat";
  static String SundayWebtoon= "sun";
  static String FinishedWebtoon= "finished";
  static String DailyWebtoon= "naverDaily";

  static Future<List<TodayWebtoonModel>> getMondayWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$MondayWebtoon');
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

  static Future<List<TodayWebtoonModel>> getTuesdayWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$TuesdayWebtoon');
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

  static Future<List<TodayWebtoonModel>> getWednesdayWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$WednesdayWebtoon');
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

  static Future<List<TodayWebtoonModel>> getThursdayWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$ThursdayWebtoon');
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

  static Future<List<TodayWebtoonModel>> getFridayWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$FridayWebtoon');
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

  static Future<List<TodayWebtoonModel>> getSaturdayWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$SaturdayWebtoon');
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

  static Future<List<TodayWebtoonModel>> getSundayWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$SundayWebtoon');
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

  static Future<List<TodayWebtoonModel>> getFinishedWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$FinishedWebtoon');
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

  static Future<List<TodayWebtoonModel>> getDailyWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$DailyWebtoon');
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
