import 'package:flutter/material.dart';

import 'text_widget.dart';

class RowWithTwoText extends StatelessWidget {
  const RowWithTwoText({
    Key? key,
    required this.title,
    required this.description,
    required this.colorScheme,
    required this.colorScheme2,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final String description;
  final Color colorScheme;
  final Color colorScheme2;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
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
      ),
    );
  }
}
