import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../app_config/app_image.dart';

class ImageCached extends StatelessWidget {
  const ImageCached({
    Key? key,
    required this.image,
    this.showImage = false,
    this.width = 224.0,
    this.height = 224.0,
    this.fit = BoxFit.contain,
    // this.widget =,
    this.color = null,
    this.onTap = null,
  }) : super(key: key);
  final String image;
  final double width;
  final bool showImage;
  final double height;
  final Color? color;
  final Function()? onTap;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: fit,
        filterQuality: FilterQuality.low,
        imageUrl: image,
        placeholder: (context, url) => Center(
          child: FadeInImage(
            placeholder: AssetImage(AppImage.logo),
            image: AssetImage(AppImage.logo),
            width: double.infinity,
            height: 120,
            fit: fit,
          ),
        ),
        errorWidget: (context, url, error) =>
            showImage ? Image.asset(AppImage.logo) : Icon(Icons.error),
      ),
    );
  }
}
