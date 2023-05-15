import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:naverwebtoon_clone/constant/gaps.dart';
import 'package:naverwebtoon_clone/constant/sizes.dart';
import 'package:naverwebtoon_clone/persistent_tab_bar.dart';

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

  LoopPageController loopPageController = LoopPageController();
  List<String> pageImage = [
    "https://cdn.pixabay.com/photo/2017/09/25/13/12/puppy-2785074_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/12/13/05/15/puppy-1903313_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/02/18/18/37/puppy-1207816_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/07/30/05/53/dog-4372036_960_720.jpg",
    "https://cdn.pixabay.com/photo/2019/02/06/15/18/puppy-3979350_960_720.jpg",
    "https://dimg.donga.com/wps/NEWS/IMAGE/2022/01/28/111500268.2.jpg",
    "https://newsimg.sedaily.com/2023/04/10/29O8ZA6BWK_1.jpg",
  ];

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
                      aspectRatio: 1,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          LoopPageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: loopPageController,
                            onPageChanged: (value) {
                              setState(() {
                                currentPageIndex = value;
                              });
                            },
                            itemCount: pageImage.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                pageImage[index],
                                fit: BoxFit.cover,
                              );
                            },
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
                              '${currentPageIndex + 1} / ${pageImage.length}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: pageImage.length,
                      position: currentPageIndex,
                      decorator: const DotsDecorator(
                          color: Colors.grey, activeColor: Colors.purple),
                    )
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
                          borderRadius: BorderRadius.circular(Sizes.size4),
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
                      ),
                    ],
                  ),
                ),
              ),
              const Center(
                child: Text('매일+'),
              ),
              const Center(
                child: Text('월요일'),
              ),
              const Center(
                child: Text('화요일'),
              ),
              const Center(
                child: Text('수요일'),
              ),
              const Center(
                child: Text('목요일'),
              ),
              const Center(
                child: Text('금요일'),
              ),
              const Center(
                child: Text('토요일'),
              ),
              const Center(
                child: Text('일요일'),
              ),
              const Center(
                child: Text('완결'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
