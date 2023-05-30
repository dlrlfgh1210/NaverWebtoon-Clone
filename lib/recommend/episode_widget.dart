import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/models/recommend_episode_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Episode extends StatelessWidget {
  final String webtoonId;
  final RecommendEpisodeModel episode;

  const Episode({
    Key? key,
    required this.webtoonId,
    required this.episode,
  }) : super(key: key);

  onButtonTap() async {
    await launchUrlString(
        "https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white12,
          boxShadow: [
            BoxShadow(
              blurRadius: 2,
              offset: const Offset(2, 2),
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: ListTile(
            leading: Image.network(
              episode.thumb,
              width: 100,
              height: 100,
              headers: const {
                "User-Agent":
                    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
              },
            ),
            title: Text(
              episode.title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Row(
              children: [
                const Icon(
                  Icons.star,
                  size: 15,
                  color: Colors.red,
                ),
                Text(
                  '${episode.rating}     ${episode.date}',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
