import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/constant/breakpoints.dart';
import 'package:naverwebtoon_clone/constant/sizes.dart';


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
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            title: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.sm,
              ),
            ),
            centerTitle: true,
            bottom: TabBar(
              splashFactory: NoSplash.splashFactory,
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size4,
              ),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  ),
              ],
            ),
          ),
        ),
    );
  }
}
