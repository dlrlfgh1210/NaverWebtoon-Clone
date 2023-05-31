import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:naverwebtoon_clone/services/recommend_api_service.dart';

class KakaoListScreen extends StatefulWidget {
  const KakaoListScreen({Key? key}) : super(key: key);

  @override
  State<KakaoListScreen> createState() => _KakaoListScreenState();
}

class _KakaoListScreenState extends State<KakaoListScreen> {
  final Future<List<TodayWebtoonModel>> kakaos = RecommendApiService.getRecommendKakaoToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.amber,
        title: const Text(
          '카카오웹툰',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder(
        future: kakaos,
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
         /*   Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailScreen(
                  thumb: recommendWebtoon.thumb,
                  id: recommendWebtoon.id,
                  title: recommendWebtoon.title,
                ),
              ),
            );*/
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