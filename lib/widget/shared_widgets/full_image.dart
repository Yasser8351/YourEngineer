import 'package:flutter/material.dart';

import 'image_network.dart';

// ignore: must_be_immutable
class FullImage extends StatelessWidget {
  const FullImage({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ImageCached(
              image: imageUrl,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}
