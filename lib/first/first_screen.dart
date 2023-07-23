import 'package:flutter/material.dart';
import 'package:naverwebtoon_clone/first/my_container.dart';
import 'package:naverwebtoon_clone/log_in/log_in_screen.dart';
import 'package:naverwebtoon_clone/sign_up/sign_up_screen.dart';


class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  void onLogInTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  void onSignUpTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Icon(
                  Icons.book,
                  size: 200,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '웹툰의 모든 것',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '네이버, 카카오, 카카오페이지 웹툰을\n 한 공간에서 감상하세요',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 200,
                ),
                GestureDetector(
                  onTap: () => onSignUpTap(context),
                  child: const MyContainer(
                    todo: '시작하기',
                    login: '',
                    bgColor: Colors.blueAccent,
                    textColor: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () => onLogInTap(context),
                  child: const MyContainer(
                    todo: '이미 계정이 있나요?',
                    login: '로그인',
                    bgColor: Colors.white,
                    textColor: Colors.grey,
                    loginTextColor: Colors.blueAccent,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
