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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Image.network(
            widget.img,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.4),
            colorBlendMode: BlendMode.darken,
          ),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 300,
                bottom: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        ),),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                      future: details,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  widget.author,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const Text("...");
                      }),
                  const SizedBox(
                    height: 350,
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
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: const Row(
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
                  )
                ],
              ),
            ),
          ),
        ],
      ));
  }
}
