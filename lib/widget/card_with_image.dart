import 'package:flutter/material.dart';

class CardWithImage extends StatelessWidget {
  const CardWithImage({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.colors,
    required this.onTap,
  }) : super(key: key);
  final double height;
  final double width;
  final Widget child;
  final Color colors;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}

class CardDecoration extends StatelessWidget {
  const CardDecoration({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.colors,
    required this.onTap,
  }) : super(key: key);
  final double height;
  final double width;
  final Widget child;
  final Color colors;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: colors),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(child: child),
      ),
    );
  }
}
