import 'package:flutter/material.dart';

class CardWithImage extends StatelessWidget {
  const CardWithImage({
    Key? key,
    required this.height,
    required this.width,
    required this.child,
    required this.colors,
    required this.onTap,
    this.isBorderRadiusTopLefZero = false,
  }) : super(key: key);
  final double height;
  final double width;
  final Widget child;
  final Color colors;
  final Function() onTap;
  final bool isBorderRadiusTopLefZero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: isBorderRadiusTopLefZero
              ? const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                )
              : BorderRadius.circular(10),
        ),
        child: child,
      ),
    );
  }
}
