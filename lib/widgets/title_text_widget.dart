import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String title;
  final Color textColor;
  const TitleText({
    super.key,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: textColor,
      ),
    );
  }
}
