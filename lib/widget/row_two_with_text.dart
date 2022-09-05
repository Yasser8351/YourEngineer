import 'package:flutter/material.dart';

import 'text_widget.dart';

class RowWithTwoText extends StatelessWidget {
  const RowWithTwoText({
    Key? key,
    required this.title,
    required this.description,
    required this.colorScheme,
    required this.colorScheme2,
  }) : super(key: key);
  final String title;
  final String description;
  final Color colorScheme;
  final Color colorScheme2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: title,
            fontSize: 18,
            color: colorScheme,
          ),
          TextWidget(
            title: description,
            fontSize: 18,
            color: colorScheme2,
          ),
        ],
      ),
    );
  }
}
