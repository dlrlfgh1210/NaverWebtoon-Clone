import 'package:flutter/material.dart';

class ChangeColorButton extends StatelessWidget {
  final bool disabled;
  const ChangeColorButton({
    super.key,
    required this.disabled,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: disabled ? Colors.grey.shade300 : Colors.blueAccent,
        ),
        duration: const Duration(milliseconds: 500),
        child: const Text(
          '가입하기',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
