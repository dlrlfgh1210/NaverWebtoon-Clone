import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/models/recommend_webtoon_model.dart';
import 'package:naverwebtoon_clone/recommend/detail_screen.dart';
import 'package:naverwebtoon_clone/screens/search_screen.dart';
import 'package:naverwebtoon_clone/services/recommend_api_service.dart';

class RecommendScreen extends StatefulWidget {
  const RecommendScreen({Key? key}) : super(key: key);

  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  final Future<List<RecommendWebtoonModel>> recommends = RecommendApiService.getRecommendToons();

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
      body: FutureBuilder(
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
    );
  }

  ListView makeList(AsyncSnapshot<List<RecommendWebtoonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
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
                  width: 230,
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
            /*  Text(
                recommendWebtoon.title,
                style: const TextStyle(
                  fontSize: 23,
                ),
              ),*/
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 30),
    );
  }
}
