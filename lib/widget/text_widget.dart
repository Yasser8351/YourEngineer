import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.title,
    required this.fontSize,
    required this.color,
    this.isTextStart = false,
  }) : super(key: key);
  final String title;
  final double fontSize;
  final Color color;
  final bool isTextStart;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: fontSize, color: color),
      textAlign: isTextStart ? TextAlign.start : TextAlign.center,
    );
  }
}
