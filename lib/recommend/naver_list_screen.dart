import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/models/recommend_webtoon_model.dart';
import 'package:naverwebtoon_clone/recommend/naver_detail_screen.dart';
import 'package:naverwebtoon_clone/services/recommend_api_service.dart';

class NaverListScreen extends StatefulWidget {
  const NaverListScreen({Key? key}) : super(key: key);

  @override
  State<NaverListScreen> createState() => _NaverListScreenState();
}

class _NaverListScreenState extends State<NaverListScreen> {
  final Future<List<RecommendWebtoonModel>> recommends = RecommendApiService.getRecommendToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text(
          '네이버웹툰',
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: FutureBuilder(
        future: recommends,
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

  GridView makeList(AsyncSnapshot<List<RecommendWebtoonModel>> snapshotList) {
    return GridView.builder(
      itemCount: snapshotList.data!.length,
      padding: const EdgeInsets.only(
        left: 10, right: 10
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
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: AspectRatio(
                  aspectRatio: 9 / 14,
                  child: Image.network(
                    recommendWebtoon.thumb,
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
