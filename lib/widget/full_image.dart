import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FullImage extends StatelessWidget {
  const FullImage({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: SizedBox(
        height: size.height * .60,
        width: double.infinity,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imageUrl,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
