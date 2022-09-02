import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({Key? key, required this.title, required this.fontSize, required this.color}) : super(key: key);
  final String title;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {

    return Text(title,style: TextStyle(
      fontSize: fontSize,
      color: color
    ),);
  }
}