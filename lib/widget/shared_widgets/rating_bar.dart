import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);

class RatingBar extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final double sizeIcon;

  const RatingBar(
      {Key? key,
      this.starCount = 5,
      this.rating = .0,
      required this.onRatingChanged,
      required this.sizeIcon,
      required this.color})
      : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        size: sizeIcon,
        color: Colors.grey,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
        size: sizeIcon,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: sizeIcon,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children:
            List.generate(starCount, (index) => buildStar(context, index)));
  }
}
