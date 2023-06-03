import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:naverwebtoon_clone/services/recommend_api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class KakaoPageDetailScreen extends StatefulWidget {
  final String title, author, img, url;
  final int webtoonId;

  const KakaoPageDetailScreen({
    Key? key,
    required this.title,
    required this.author,
    required this.img,
    required this.url,
    required this.webtoonId,
  }) : super(key: key);

  @override
  State<KakaoPageDetailScreen> createState() => _KakaoPageDetailScreenState();
}

class _KakaoPageDetailScreenState extends State<KakaoPageDetailScreen> {
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
    details = RecommendApiService.getRecommendKakaoPageToons();
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
        foregroundColor: Colors.purple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                ),
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
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '제목: ${widget.title}',
                                style: const TextStyle(fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                '작가: ${widget.author}',
                                style: const TextStyle(
                                    fontSize: 16,),
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
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
                      'https://page.kakao.com/content/${widget.webtoonId.toString().substring(5, 13)}',
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple,
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
