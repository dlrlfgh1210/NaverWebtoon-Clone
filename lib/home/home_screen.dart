import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naverwebtoon_clone/constant/gaps.dart';
import 'package:naverwebtoon_clone/constant/sizes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  int currentPageIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: tabs.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.cookie, color: Colors.amber, size: 20),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon:
                        const Icon(Icons.search, color: Colors.white, size: 20),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 2,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          PageView(
                            scrollDirection: Axis.horizontal,
                            controller: pageController,
                            onPageChanged: (value) {
                              setState(() {
                                currentPageIndex = value;
                              });
                            },
                            children: [
                              Image.network(
                                "https://cdn.pixabay.com/photo/2017/09/25/13/12/puppy-2785074_960_720.jpg",
                                fit: BoxFit.fill,
                              ),
                              Image.network(
                                "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_960_720.jpg",
                                fit: BoxFit.fill,
                              ),
                              Image.network(
                                "https://cdn.pixabay.com/photo/2016/02/18/18/37/puppy-1207816_960_720.jpg",
                                fit: BoxFit.fill,
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(500)),
                            child: Text(
                              '${currentPageIndex+1} / 3',
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    SmoothPageIndicator(
                      controller: pageController,
                      count: 3,
                      effect: const WormEffect(
                        dotColor: Colors.grey,
                        activeDotColor: Colors.purple,
                        radius: 5,
                        dotHeight: 10,
                        dotWidth: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                  itemCount: 10,
                  padding: const EdgeInsets.all(
                    Sizes.size10,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: Sizes.size6,
                    mainAxisSpacing: Sizes.size6,
                    childAspectRatio: 9 / 20,
                  ),
                  itemBuilder: (context, index) => LayoutBuilder(
                      builder: (context, constraints) => Column(
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size4),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 9 / 15,
                                  child: FadeInImage.assetNetwork(
                                    fit: BoxFit.cover,
                                    placeholder:
                                        "https://avatars.githubusercontent.com/u/121213240?v=4",
                                    image:
                                        "https://shared-comic.pstatic.net/thumb/webtoon/736277/thumbnail/thumbnail_IMAG21_bbbe3f76-021e-4dbc-830a-4358c1abec0c.jpg",
                                  ),
                                ),
                              ),
                              Gaps.v10,
                              const Text(
                                "싸움독학",
                                style: TextStyle(
                                    fontSize: Sizes.size16,
                                    fontWeight: FontWeight.bold,
                                    height: 1.1),
                              ),
                              Gaps.v8,
                              Row(
                                children: [
                                  const Expanded(
                                    child: Text(
                                      "박태준 만화회사 / 김정현 스튜디오",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Gaps.h2,
                                  FaIcon(
                                    FontAwesomeIcons.solidStar,
                                    size: Sizes.size16,
                                    color: Colors.grey.shade600,
                                  ),
                                  Gaps.h2,
                                  const Text(
                                    "9.72",
                                  )
                                ],
                              )
                            ],
                          )))
            ],
          ),
        ),
      ),
    );
  }
}
