import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

class BuildRowList extends StatelessWidget {
  const BuildRowList(
      {Key? key,
      this.title,
      required this.colorScheme,
      this.icon,
      this.description})
      : super(key: key);
  final title;
  final ColorScheme colorScheme;
  final icon;
  final description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: colorScheme.primary,
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: TextWidget(
              title: description,
              fontSize: 15,
              color: colorScheme.secondary,
            ),
          ),
          TextWidget(
            title: "  :  ",
            fontSize: 15,
            color: colorScheme.secondary,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: TextWidget(
              title: title,
              fontSize: 15,
              color: colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
