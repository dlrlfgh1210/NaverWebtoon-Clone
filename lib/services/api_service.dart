import 'dart:convert';

import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "https://korea-webtoon-api.herokuapp.com/";
  static String MondayWebtoon = "?perPage=20&service=naver&updateDay=mon";
  static String TuesdayWebtoon = "?perPage=20&service=naver&updateDay=tue";
  static String WednesdayWebtoon = "?perPage=20&service=naver&updateDay=wed";
  static String ThursdayWebtoon = "?perPage=20&service=naver&updateDay=thu";
  static String FridayWebtoon = "?perPage=20&service=naver&updateDay=fri";
  static String SaturdayWebtoon = "?perPage=20&service=naver&updateDay=sat";
  static String SundayWebtoon = "?perPage=20&service=naver&updateDay=sun";
  static String FinishedWebtoon = "?perPage=20&service=naver&updateDay=finished";
  static String DailyWebtoon = "?perPage=20&service=naver&updateDay=naverDaily";

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
