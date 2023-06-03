import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:naverwebtoon_clone/models/recommend_webtoon_model.dart';
import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:naverwebtoon_clone/recommend/kakao_detail_screen.dart';
import 'package:naverwebtoon_clone/recommend/kakao_list_screen.dart';
import 'package:naverwebtoon_clone/recommend/kakao_page_detail_screen.dart';
import 'package:naverwebtoon_clone/recommend/kakao_page_list_screen.dart';
import 'package:naverwebtoon_clone/recommend/naver_list_screen.dart';
import 'package:naverwebtoon_clone/recommend/naver_detail_screen.dart';
import 'package:naverwebtoon_clone/screens/search_screen.dart';
import 'package:naverwebtoon_clone/services/recommend_api_service.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({Key? key}) : super(key: key);

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  final Future<List<RecommendWebtoonModel>> recommends =
      RecommendApiService.getRecommendToons();
  final Future<List<TodayWebtoonModel>> kakaos =
      RecommendApiService.getRecommendKakaoToons();
  final Future<List<TodayWebtoonModel>> kakaoPages = RecommendApiService.getRecommendKakaoPageToons();

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ko_KR', null);

    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('EEEE', 'ko_KR').format(now);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(
          '$dayOfWeek 추천 웹툰',
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
            icon: const Icon(Icons.search, color: Colors.black, size: 25),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '네이버 웹툰',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NaverListScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          size: 30,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 230,
                    child: FutureBuilder(
                      future: recommends,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return makeList(snapshot);
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '카카오 웹툰',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                           Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const KakaoListScreen(),
                          ),
                        );
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          size: 30,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: FutureBuilder(
                      future: kakaos,
                      builder: (context, snapshotKakao) {
                        if (snapshotKakao.hasData) {
                          return makeKakaoList(snapshotKakao);
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          '카카오페이지 웹툰',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.purple,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const KakaoPageListScreen(),
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.chevron_right,
                          size: 30,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 350,
                    child: FutureBuilder(
                      future: kakaoPages,
                      builder: (context, snapshotKakaoPage) {
                        if (snapshotKakaoPage.hasData) {
                          return makeKakaoPageList(snapshotKakaoPage);
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<RecommendWebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      itemBuilder: (context, index) {
        var recommendWebtoon = snapshot.data![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NaverDetailScreen(
                  thumb: recommendWebtoon.thumb,
                  id: recommendWebtoon.id,
                  title: recommendWebtoon.title,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Hero(
                tag: recommendWebtoon.id,
                child: Container(
                  width: 150,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(15, 15),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],
                  ),
                  child: Image.network(
                    recommendWebtoon.thumb,
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 30),
    );
  }

  ListView makeKakaoList(AsyncSnapshot<List<TodayWebtoonModel>> snapshotKakao) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshotKakao.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      itemBuilder: (context, index) {
        var recommendKakaoWebtoon = snapshotKakao.data![index];
        return GestureDetector(
          onTap: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KakaoDetailScreen(
                  img: recommendKakaoWebtoon.img,
                  webtoonId: recommendKakaoWebtoon.webtoonId,
                  title: recommendKakaoWebtoon.title,
                  author: recommendKakaoWebtoon.author,
                  url: recommendKakaoWebtoon.url,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Hero(
                tag: recommendKakaoWebtoon.webtoonId,
                child: Container(
                  width: 200,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey)
                      /*    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(15, 15),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],*/
                      ),
                  child: Image.network(
                    recommendKakaoWebtoon.img,
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 30),
    );
  }

  ListView makeKakaoPageList(AsyncSnapshot<List<TodayWebtoonModel>> snapshotKakaoPage) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshotKakaoPage.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      itemBuilder: (context, index) {
        var recommendKakaoPageWebtoon = snapshotKakaoPage.data![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KakaoPageDetailScreen(
                  img: recommendKakaoPageWebtoon.img,
                  webtoonId: recommendKakaoPageWebtoon.webtoonId,
                  title: recommendKakaoPageWebtoon.title,
                  author: recommendKakaoPageWebtoon.author,
                  url: recommendKakaoPageWebtoon.url,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Hero(
                tag: recommendKakaoPageWebtoon.webtoonId,
                child: Container(
                  width: 150,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey)
                    /*    boxShadow: [
                      BoxShadow(
                        blurRadius: 20,
                        offset: const Offset(15, 15),
                        color: Colors.black.withOpacity(0.5),
                      )
                    ],*/
                  ),
                  child: Image.network(
                    recommendKakaoPageWebtoon.img,
                    headers: const {
                      "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 30),
    );
  }
}
