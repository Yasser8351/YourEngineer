import 'package:flutter/cupertino.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.title,
    required this.fontSize,
    required this.color,
    this.isTextStart = false,
    this.isTextEnd = false,
    this.textOverflow = null,
    this.isTextJustify = false,
  }) : super(key: key);
  final String title;
  final double fontSize;
  final Color color;
  final bool isTextStart;
  final bool isTextEnd;
  final bool isTextJustify;
  final TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 6,
      title,
      overflow: textOverflow,
      style: TextStyle(fontSize: fontSize, color: color),
      textAlign: isTextStart
          ? TextAlign.start
          : isTextEnd
              ? TextAlign.end
              : isTextJustify
                  ? TextAlign.justify
                  : TextAlign.center,
    );
  }
}
