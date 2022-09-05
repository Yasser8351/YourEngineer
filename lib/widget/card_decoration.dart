import 'package:flutter/material.dart';

class CardDecoration extends StatelessWidget {
  const CardDecoration({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.onTap,
  }) : super(key: key);
  final double height;
  final double width;
  final Widget child;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          //border: Border.all(color: colors),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(borderOnForeground: true, elevation: 5, child: child),
      ),
    );
  }
}
