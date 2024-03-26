import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListRectangular extends StatelessWidget {
  const ShimmerListRectangular({Key? key, this.itemCount}) : super(key: key);
  final int? itemCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 0),
      child: Container(
        height: Get.height,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: itemCount ?? 4,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Color.fromARGB(255, 212, 212, 212),
              child: ContainerWithDecoration(
                bottomLeft: 10,
                bottomRight: 10,
                topLeft: 10,
                topRight: 10,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 110,
                      height: 170,
                    ),
                    const SizedBox(width: 33),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ShimmerCircular extends StatelessWidget {
  const ShimmerCircular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .052),
      child: Container(
          height: 90,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Color.fromARGB(255, 212, 212, 212),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: ContainerWithDecoration(
                    bottomLeft: 150,
                    bottomRight: 150,
                    topLeft: 150,
                    topRight: 150,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 90,
                          // width: Get.width * .9,
                          // height: Get.width * .57,
                        ),
                        const SizedBox(width: 33),
                      ],
                    ),
                  ),
                )),
          )),
    );
  }
}

class ShimmerHorizontal extends StatelessWidget {
  const ShimmerHorizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 15, top: 15),
      child: Container(
          height: 170,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) => Shimmer.fromColors(
                baseColor: Colors.white,
                highlightColor: Color.fromARGB(255, 212, 212, 212),
                child: ContainerWithDecoration(
                  bottomLeft: 10,
                  bottomRight: 10,
                  topLeft: 10,
                  topRight: 10,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 110,
                        height: 170,
                        // width: Get.width * .9,
                        // height: Get.width * .57,
                      ),
                      const SizedBox(width: 33),
                    ],
                  ),
                )),
          )),
    );
  }
}

class ShimmerRectangular extends StatelessWidget {
  const ShimmerRectangular({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(start: 25, top: 15, end: 25),
        child: Container(
          height: 150,
          child: Shimmer.fromColors(
              baseColor: Colors.white,
              highlightColor: Color.fromARGB(255, 212, 212, 212),
              child: ContainerWithDecoration(
                bottomLeft: 10,
                bottomRight: 10,
                topLeft: 10,
                topRight: 10,
                child: Row(
                  children: [
                    SizedBox(
                      width: 110,
                      height: 170,
                      // width: Get.width * .9,
                      // height: Get.width * .57,
                    ),
                    const SizedBox(width: 33),
                  ],
                ),
              )),
        ));
  }
}

class ContainerWithDecoration extends StatelessWidget {
  const ContainerWithDecoration(
      {Key? key,
      this.child = null,
      this.height = null,
      this.width = null,
      this.color = null,
      this.marginTop = 0,
      this.onTap = null,
      this.topLeft = 0,
      this.topRight = 0,
      this.bottomRight = 0,
      this.bottomLeft = 0,
      this.border,
      this.paddinLeft = 0,
      this.paddingRight = 0,
      this.paddingTop = 0,
      this.paddingBottom = 0})
      : super(key: key);
  final Widget? child;
  final Function()? onTap;
  final double? height;
  final double? width;
  final double? marginTop;
  final Color? color;
  final double topLeft;
  final double topRight;
  final double bottomRight;
  final double bottomLeft;
  final double paddinLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: marginTop),
        InkWell(
          onTap: onTap,
          child: Container(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: paddingBottom,
                left: paddinLeft,
                right: paddingRight,
                top: paddingTop,
              ),
              child: child,
            ),
            height: height,
            width: width,
            // height: MediaQuery.of(context).size.height * 1.1,
            decoration: BoxDecoration(
              border: border,
              color: color ?? Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(topLeft),
                topRight: Radius.circular(topRight),
                bottomRight: Radius.circular(bottomRight),
                bottomLeft: Radius.circular(bottomLeft),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
