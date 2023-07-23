import 'package:flutter/material.dart';

import 'package:naverwebtoon_clone/log_in/log_in_screen.dart';
import 'package:naverwebtoon_clone/sign_up/change_color_button.dart';
import 'package:naverwebtoon_clone/sign_up/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCheckController = TextEditingController();

  String username = '';
  String email = '';
  String password = '';
  String passwordCheck = '';

  @override
  void initState() {
    super.initState();

    usernameController.addListener(() {
      setState(() {
        username = usernameController.text;
      });
    });
    emailController.addListener(() {
      setState(() {
        email = emailController.text;
      });
    });
    passwordController.addListener(() {
      setState(() {
        password = passwordController.text;
      });
    });
    passwordCheckController.addListener(() {
      setState(() {
        passwordCheck = passwordCheckController.text;
      });
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordCheckController.dispose();
    super.dispose();
  }

  String? isEmailValid() {
    if (email.isEmpty) return null;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(email)) {
      return '잘못된 이메일 형식입니다.';
    }
    return null;
  }

  String? isPasswordValid() {
    if (password.isEmpty) return null;
    final regExp = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');
    if (!regExp.hasMatch(password)) {
      return '특수문자, 대소문자, 숫자 등 8~15자로 입력하세요.';
    }
    if (password != passwordCheck) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }

  String? isPasswordCheckValid() {
    if (passwordCheck.isEmpty) return null;
    final regExp = RegExp(
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$');
    if (!regExp.hasMatch(passwordCheck)) {
      return '특수문자, 대소문자, 숫자 등 8~15자로 입력하세요.';
    }
    if (passwordCheck != password) {
      return '비밀번호가 일치하지 않습니다.';
    }
    return null;
  }

  void onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  onSubmit() {
    if (username.isEmpty ||
        email.isEmpty ||
        isEmailValid() != null ||
        password.isEmpty ||
        isPasswordValid() != null ||
        passwordCheck.isEmpty ||
        isPasswordCheckValid() != null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LogInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            '회원가입',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              SignUpForm(
                signUpInfo: '별명',
                signUpHint: '별명을 만들어 주세요',
                signUpController: usernameController,
              ),
              SignUpForm(
                signUpInfo: '이메일',
                signUpHint: '예: carrotmarket123@carrot.com',
                signUpController: emailController,
                signUpKeyBoard: TextInputType.emailAddress,
                isValid: isEmailValid(),
              ),
              SignUpForm(
                signUpInfo: '비밀번호',
                signUpHint: '비밀번호를 입력해주세요',
                signUpController: passwordController,
                signUpKeyBoard: TextInputType.visiblePassword,
                isValid: isPasswordValid(),
              ),
              SignUpForm(
                signUpInfo: '비밀번호확인',
                signUpHint: '비밀번호를 한번 더 입력해주세요',
                signUpController: passwordCheckController,
                signUpKeyBoard: TextInputType.visiblePassword,
                isValid: isPasswordCheckValid(),
              ),
              GestureDetector(
                onTap: onSubmit,
                child: ChangeColorButton(
                  disabled: username.isEmpty ||
                      email.isEmpty ||
                      password.isEmpty ||
                      passwordCheck.isEmpty,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
