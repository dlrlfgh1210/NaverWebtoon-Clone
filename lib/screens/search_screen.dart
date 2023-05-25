import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String result = '';
  List data = [];

  final TextEditingController _textEditingController = TextEditingController();

  void _onSearchSubmitted(String result) {
    getJSONData();
    data.clear();
  }

  void _onSearchChanged(String result) {
    data.clear();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: CupertinoSearchTextField(
          placeholder: '제목 또는 작가명 검색',
          backgroundColor: Colors.white,
          controller: _textEditingController,
          onSubmitted: _onSearchSubmitted,
          onChanged: _onSearchChanged,
        ),
      ),
      body: data.isEmpty
          ? const Center(
              child: Text(
                "데이터가 없습니다",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )
          : ListView.separated(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (data[index]['service'].toString() == 'naver') {
                      launchUrl(
                        Uri.parse(
                          'https://m.comic.naver.com/webtoon/list?titleId=${data[index]['webtoonId'].toString().substring(7, 13)}',
                        ),
                      );
                    } else if (data[index]['service'].toString() == 'kakao') {
                      launchUrl(
                        Uri.parse(
                          'https://webtoon.kakao.com/content/${data[index]['title']}/${data[index]['webtoonId'].toString().substring(9, 13)}',
                        ),
                      );
                    } else if (data[index]['service'].toString() ==
                        'kakaoPage') {
                      launchUrl(
                        Uri.parse(
                          'https://page.kakao.com/content/${data[index]['webtoonId'].toString().substring(5, 13)}',
                        ),
                      );
                    }
                  },
                  child: ListTile(
                    leading: Image.network(
                      data[index]['img'],
                      headers: const {
                        "User-Agent":
                            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36",
                      },
                    ),
                    title: Text(
                      data[index]['title'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                      ),
                    ),
                    subtitle: Text(
                      data[index]['author'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => Container(
                height: 1,
                color: Colors.red,
              ),
              itemCount: data.length,
            ),
    );
  }

  Future<String> getJSONData() async {
    final url = Uri.parse(
        'https://korea-webtoon-api.herokuapp.com/search?keyword=${_textEditingController.text}');
    var response = await http.get(url);

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['webtoons'];
      data.addAll(result);
    });
    return response.body;
  }
}
