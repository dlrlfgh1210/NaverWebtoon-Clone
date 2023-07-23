import 'package:flutter/material.dart';

class LogInForm extends StatelessWidget {
  final String logInHint;
  final Widget? eyePass;
  final bool secret;
  final dynamic saveValue;
  final TextInputType logInKeyBoard;
  const LogInForm({
    super.key,
    required this.logInHint,
    required this.secret,
    required this.saveValue,
    required this.logInKeyBoard,
    this.eyePass,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: secret,
      keyboardType: logInKeyBoard,
      decoration: InputDecoration(
        suffix: eyePass,
        hintText: logInHint,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade400,
          ),
        ),
      ),
      validator: (value) {
        if (value != null && value.isEmpty) {
          return "제대로 입력해주세요";
        }
        return null;
      },
      onSaved: saveValue,
    );
  }
}
