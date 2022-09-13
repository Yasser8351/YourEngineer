import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Color color;

  final Function() onTap;
  const ButtonWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .075,
      width: size.width,
      // margin: EdgeInsets.symmetric(
      //   horizontal: size.width * 0.07,
      //   vertical: size.height * 0.035,
      // ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () => onTap(),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
