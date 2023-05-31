import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/models/recommend_webtoon_model.dart';
import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:naverwebtoon_clone/recommend/detail_screen.dart';
import 'package:naverwebtoon_clone/recommend/kakao_list_screen.dart';
import 'package:naverwebtoon_clone/recommend/list_screen.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: const Text(
          '추천웹툰',
          style: TextStyle(
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
      body: Column(
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
                            builder: (context) => const ListScreen(),
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
                  height: 300,
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
                  height: 300,
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
        ],
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
                builder: (context) => DetailScreen(
                  thumb: recommendWebtoon.thumb,
                  id: recommendWebtoon.id,
                  title: recommendWebtoon.title,
                ),
                /*fullscreenDialog: true,*/
              ),
            );
          },
          child: Column(
            children: [
              Hero(
                tag: recommendWebtoon.id,
                child: Container(
                  width: 200,
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
            /*    Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  thumb: recommendWebtoon.thumb,
                  id: recommendWebtoon.id,
                  title: recommendWebtoon.title,
                ),
                */ /*fullscreenDialog: true,*/ /*
              ),
            );*/
          },
          child: Column(
            children: [
              Hero(
                tag: recommendKakaoWebtoon.webtoonId,
                child: Container(
                  width: 250,
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
}
