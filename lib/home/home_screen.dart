import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:naverwebtoon_clone/constant/gaps.dart';
import 'package:naverwebtoon_clone/constant/sizes.dart';
import 'package:naverwebtoon_clone/models/today_webtoon_model.dart';
import 'package:naverwebtoon_clone/persistent_tab_bar.dart';
import 'package:naverwebtoon_clone/screens/search_screen.dart';
import 'package:naverwebtoon_clone/services/api_service.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

final tabs = [
  "신작",
  "매일+",
  "월",
  "화",
  "수",
  "목",
  "금",
  "토",
  "일",
  "완결",
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<List<TodayWebtoonModel>> monday = ApiService.getMondayWebtoons();
  final Future<List<TodayWebtoonModel>> tuesday = ApiService.getTuesdayWebtoons();
  final Future<List<TodayWebtoonModel>> wednesday = ApiService.getWednesdayWebtoons();
  final Future<List<TodayWebtoonModel>> thursday = ApiService.getThursdayWebtoons();
  final Future<List<TodayWebtoonModel>> friday = ApiService.getFridayWebtoons();
  final Future<List<TodayWebtoonModel>> saturday = ApiService.getSaturdayWebtoons();
  final Future<List<TodayWebtoonModel>> sunday = ApiService.getSundayWebtoons();
  final Future<List<TodayWebtoonModel>> finished = ApiService.getFinishedWebtoons();
  final Future<List<TodayWebtoonModel>> daily = ApiService.getDailyWebtoons();

  int currentPageIndex = 0;
  int currentPage = 0;

  final ScrollController _scrollController = ScrollController();

  Color _appBarColor = Colors.red;



  LoopPageController loopPageController = LoopPageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (currentPage < 20) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      loopPageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    setState(() {
      _appBarColor = _scrollController.position.pixels > 0
          ? Colors.blue
          : Colors.red;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: _appBarColor,
                pinned: true,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.cookie, color: Colors.amber, size: 20),
                  ),
                  const SizedBox(
                    width: 250,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SearchScreen()),
                      );
                    },
                    icon:
                        const Icon(Icons.search, color: Colors.white, size: 20),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: FutureBuilder(
                        future: saturday,
                        builder: (context, snapshotImg) {
                          if (snapshotImg.hasData) {
                            return makeImgList(snapshotImg);
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
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              )
            ];
          },
          body: TabBarView(
            children: [
              FutureBuilder(
                future: monday,
                builder: (context, snapshotToday) {
                  if (snapshotToday.hasData) {
                    return makeTodayList(snapshotToday);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: tuesday,
                builder: (context, snapshotToday) {
                  if (snapshotToday.hasData) {
                    return makeTodayList(snapshotToday);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: wednesday,
                builder: (context, snapshotToday) {
                  if (snapshotToday.hasData) {
                    return makeTodayList(snapshotToday);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: thursday,
                builder: (context, snapshotToday) {
                  if (snapshotToday.hasData) {
                    return makeTodayList(snapshotToday);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: friday,
                builder: (context, snapshotToday) {
                  if (snapshotToday.hasData) {
                    return makeTodayList(snapshotToday);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: saturday,
                builder: (context, snapshotToday) {
                  if (snapshotToday.hasData) {
                    return makeTodayList(snapshotToday);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: sunday,
                builder: (context, snapshotToday) {
                  if (snapshotToday.hasData) {
                    return makeTodayList(snapshotToday);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: finished,
                builder: (context, snapshotToday) {
                  if (snapshotToday.hasData) {
                    return makeTodayList(snapshotToday);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              FutureBuilder(
                future: daily,
                builder: (context, snapshotToday) {
                  if (snapshotToday.hasData) {
                    return makeTodayList(snapshotToday);
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const Center(
                child: Text('신작'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  GridView makeTodayList(AsyncSnapshot<List<TodayWebtoonModel>> snapshotToday) {
    return GridView.builder(
      itemCount: snapshotToday.data!.length,
      padding: const EdgeInsets.all(
        Sizes.size10,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: Sizes.size6,
        mainAxisSpacing: Sizes.size6,
        childAspectRatio: 9 / 20,
      ),
      itemBuilder: (context, index) {
        var todayWebtoon = snapshotToday.data![index];
        return GestureDetector(
          onTap: () {
            launchUrl(
              Uri.parse(
                'https://m.comic.naver.com/webtoon/list?titleId=${todayWebtoon.webtoonId.toString().substring(7, 13)}',
              ),
            );
          },
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.size4),
                ),
                child: AspectRatio(
                  aspectRatio: 9 / 15,
                  child: Image.network(
                    todayWebtoon.img,
                    headers: const {
                      "User-Agent":
                          "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                    },
                  ),
                ),
              ),
              Gaps.v10,
              Text(
                todayWebtoon.title,
                style: const TextStyle(
                    fontSize: Sizes.size10,
                    fontWeight: FontWeight.bold,
                    height: 1.1),
              ),
              Gaps.v8,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      todayWebtoon.author,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Gaps.h2,
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    size: Sizes.size4,
                    color: Colors.grey.shade600,
                  ),
                  Gaps.h2,
                  const Text("9.72")
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  LoopPageView makeImgList(AsyncSnapshot<List<TodayWebtoonModel>> snapshotImg) {
    return LoopPageView.builder(
      pageSnapping: true,
      scrollDirection: Axis.horizontal,
      controller: loopPageController,
      onPageChanged: (value) {
        setState(() {
          currentPageIndex = value;
        });
      },
      itemCount: snapshotImg.data!.length,
      itemBuilder: (context, index) {
        var webtoonImg = snapshotImg.data![index];
        return GestureDetector(
          onTap: () {
            launchUrl(
              Uri.parse(
                'https://m.comic.naver.com/webtoon/list?titleId=${webtoonImg.webtoonId.toString().substring(7, 13)}',
              ),
            );
          },
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  webtoonImg.img,
                  headers: const {
                    "User-Agent":
                        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                  },
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 25),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(
                  horizontal: 130,
                ),
                child: PageViewDotIndicator(
                  duration: const Duration(seconds: 5),
                  currentItem: currentPageIndex,
                  count: snapshotImg.data!.length,
                  unselectedColor: Colors.grey,
                  selectedColor: Colors.purple,
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(500)),
                  child: Text(
                    '${currentPageIndex + 1} / ${snapshotImg.data!.length}',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
