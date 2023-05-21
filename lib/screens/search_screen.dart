import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:naverwebtoon_clone/services/api_service.dart';
import 'package:url_launcher/url_launcher.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Future<List<TodayWebtoonModel>> search = ApiService.getSearchWebtoons();

  final TextEditingController _textEditingController = TextEditingController();


  void _onSearchChanged(String value) {

  }

  void _onSearchSubmitted(String value) {

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
          onChanged: _onSearchChanged,
          onSubmitted: _onSearchSubmitted,
        ),
      ),
      body: FutureBuilder(
        future: search,
        builder: (context, snapshotSearch) {
          if (snapshotSearch.hasData) {
            return makeSearchList(snapshotSearch);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

ListView makeSearchList(AsyncSnapshot<List<TodayWebtoonModel>> snapshotSearch) {
  return ListView.separated(
    itemBuilder: (context, index) {
      var webtoonSearch = snapshotSearch.data![index];
      return GestureDetector(
        onTap: () {
          if(webtoonSearch.service.toString() == 'naver') {
            launchUrl(
              Uri.parse('https://m.comic.naver.com/webtoon/list?titleId=${webtoonSearch.webtoonId.toString().substring(7, 13)}',

              ),
            ) ;}
          else if(webtoonSearch.service.toString() == 'kakao') {
            launchUrl(
              Uri.parse(
                'https://webtoon.kakao.com/content/${webtoonSearch.title}/${webtoonSearch.webtoonId.toString().substring(9, 13)}',
              ),
            ) ;}
          else if(webtoonSearch.service.toString() == 'kakaoPage') {
            launchUrl(
              Uri.parse(
                'https://page.kakao.com/content/${webtoonSearch.webtoonId.toString().substring(5, 13)}',
              ),
            ) ;}
        },
        child: ListTile(
          leading: Image.network(
            webtoonSearch.img,
            headers: const {
              "User-Agent":
                  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/113.0.0.0 Safari/537.36",
            },

          ),
          title: Text(
            webtoonSearch.title,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          subtitle: Text(
            webtoonSearch.author,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
      );
    },
    separatorBuilder: (context, index) =>
      Container(
        height: 1,
        color: Colors.red,
      ),
    itemCount: snapshotSearch.data!.length,
  );
}
