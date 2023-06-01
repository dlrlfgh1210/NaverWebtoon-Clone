import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:naverwebtoon_clone/services/recommend_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class KakaoDetailScreen extends StatefulWidget {
  final String title, author, img, url;
  final int webtoonId;

  const KakaoDetailScreen({
    Key? key,
    required this.title,
    required this.author,
    required this.img,
    required this.url,
    required this.webtoonId,
  }) : super(key: key);

  @override
  State<KakaoDetailScreen> createState() => _KakaoDetailScreenState();
}

class _KakaoDetailScreenState extends State<KakaoDetailScreen> {
  late Future<List<TodayWebtoonModel>> details;
  late SharedPreferences preferences;
  bool isLiked = false;

  Future initPreferences() async {
    preferences = await SharedPreferences.getInstance();
    final likedToons = preferences.getStringList('likedToons');
    if (likedToons != null) {
      if (likedToons.contains(widget.webtoonId.toString()) == true) {
        setState(() {
          isLiked = true;
        });
      }
    } else {
      await preferences.setStringList('likedToons', []);
    }
  }

  @override
  void initState() {
    super.initState();
    details = RecommendApiService.getRecommendKakaoToons();
    initPreferences();
  }

  onHeartTap() async {
    final likedToons = preferences.getStringList('likedToons');
    if (likedToons != null) {
      if (isLiked) {
        likedToons.remove(widget.webtoonId.toString());
      } else {
        likedToons.add(widget.webtoonId.toString());
      }
      await preferences.setStringList('likedToons', likedToons);
      setState(() {
        isLiked = !isLiked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.amber,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
            const Icon(Icons.more_vert),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.webtoonId,
                    child: Container(
                      width: 300,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 20,
                            offset: const Offset(10, 10),
                            color: Colors.black.withOpacity(0.5),
                          )
                        ],
                      ),
                      child: Image.network(widget.img),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: details,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.author,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        IconButton(
                          iconSize: 30,
                          color: isLiked ? Colors.red : Colors.grey,
                          onPressed: onHeartTap,
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_outline,
                          ),
                        ),
                      ],
                    );
                  }
                  return const Text("...");
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: double.maxFinite,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  launchUrl(
                    Uri.parse(
                      'https://webtoon.kakao.com/content/${widget.title}/${widget.webtoonId.toString().substring(9, 13)}',
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '보러 가기',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
