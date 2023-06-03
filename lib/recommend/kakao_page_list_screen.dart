import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:naverwebtoon_clone/recommend/kakao_page_detail_screen.dart';
import 'package:naverwebtoon_clone/services/recommend_api_service.dart';

class KakaoPageListScreen extends StatefulWidget {
  const KakaoPageListScreen({Key? key}) : super(key: key);

  @override
  State<KakaoPageListScreen> createState() => _KakaoPageListScreenState();
}

class _KakaoPageListScreenState extends State<KakaoPageListScreen> {
  final Future<List<TodayWebtoonModel>> kakaoPages = RecommendApiService.getRecommendKakaoPageToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.purple,
        title: const Text(
          '카카오페이지웹툰',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder(
        future: kakaoPages,
        builder: (context, snapshotList) {
          if (snapshotList.hasData) {
            return makeList(snapshotList);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  GridView makeList(AsyncSnapshot<List<TodayWebtoonModel>> snapshotList) {
    return GridView.builder(
      itemCount: snapshotList.data!.length,
      padding: const EdgeInsets.only(
        left: 10, right: 10, bottom: 20,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 6,
        childAspectRatio: 9 / 16,
      ),
      itemBuilder: (context, index) {
        var recommendWebtoon = snapshotList.data![index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KakaoPageDetailScreen(
                  img: recommendWebtoon.img,
                  webtoonId: recommendWebtoon.webtoonId,
                  title: recommendWebtoon.title,
                  author: recommendWebtoon.author,
                  url: recommendWebtoon.url,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),

                child: AspectRatio(
                  aspectRatio: 9 / 14,
                  child: Image.network(
                    recommendWebtoon.img,
                    headers: const {
                      "User-Agent":
                      "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                ),
              ),
              Text(
                recommendWebtoon.title,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}