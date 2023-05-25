import 'dart:convert';

import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "https://korea-webtoon-api.herokuapp.com/";
  static String mondayWebtoon = "?perPage=20&service=naver&updateDay=mon";
  static String tuesdayWebtoon = "?perPage=20&service=naver&updateDay=tue";
  static String wednesdayWebtoon = "?perPage=20&service=naver&updateDay=wed";
  static String thursdayWebtoon = "?perPage=20&service=naver&updateDay=thu";
  static String fridayWebtoon = "?perPage=20&service=naver&updateDay=fri";
  static String saturdayWebtoon = "?perPage=20&service=naver&updateDay=sat";
  static String sundayWebtoon = "?perPage=20&service=naver&updateDay=sun";
  static String finishedWebtoon = "?perPage=20&service=naver&updateDay=finished";
  static String dailyWebtoon = "?perPage=20&service=naver&updateDay=naverDaily";

  static Future<List<TodayWebtoonModel>> getMondayWebtoons() async {
    List<TodayWebtoonModel> todayInstances = [];
    final url = Uri.parse('$baseUrl$mondayWebtoon');
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
    final url = Uri.parse('$baseUrl$tuesdayWebtoon');
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
    final url = Uri.parse('$baseUrl$wednesdayWebtoon');
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
    final url = Uri.parse('$baseUrl$thursdayWebtoon');
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
    final url = Uri.parse('$baseUrl$fridayWebtoon');
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
    final url = Uri.parse('$baseUrl$saturdayWebtoon');
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
    final url = Uri.parse('$baseUrl$sundayWebtoon');
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
    final url = Uri.parse('$baseUrl$finishedWebtoon');
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
    final url = Uri.parse('$baseUrl$dailyWebtoon');
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
