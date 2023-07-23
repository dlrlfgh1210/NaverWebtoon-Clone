import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final String todo;
  final String? login;
  final Color bgColor;
  final Color textColor;
  final Color? loginTextColor;
  const MyContainer({
    super.key,
    required this.todo,
    required this.bgColor,
    required this.textColor,
    this.login,
    this.loginTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10,
        ),
        color: bgColor,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            todo,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w800,
              fontSize: 17,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            login!,
            style: TextStyle(
              color: loginTextColor,
              fontWeight: FontWeight.w700,
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
