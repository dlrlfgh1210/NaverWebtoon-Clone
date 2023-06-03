import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:naverwebtoon_clone/constant/sizes.dart';
import 'package:naverwebtoon_clone/home/home_screen.dart';
import 'package:naverwebtoon_clone/nav_tab.dart';
import 'package:naverwebtoon_clone/recommend/recommend_screen.dart';


class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const RecommendScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 2,
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: Container(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: Container(),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "웹툰",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.calendar,
                selectedIcon: FontAwesomeIcons.solidCalendar,
                onTap: () => _onTap(0),
              ),
              NavTab(
                text: "추천완결",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.addressBook,
                selectedIcon: FontAwesomeIcons.solidAddressBook,
                onTap: () => _onTap(1),
              ),
              NavTab(
                text: "베스트도전",
                isSelected: _selectedIndex == 2,
                icon: FontAwesomeIcons.star,
                selectedIcon: FontAwesomeIcons.solidStar,
                onTap: () => _onTap(2),
              ),
              NavTab(
                text: "MY",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.faceSmile,
                selectedIcon: FontAwesomeIcons.solidFaceSmile,
                onTap: () => _onTap(3),
              ),
              NavTab(
                text: "더보기",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.bell,
                selectedIcon: FontAwesomeIcons.solidBell,
                onTap: () => _onTap(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
