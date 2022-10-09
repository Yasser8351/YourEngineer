import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: size.width,
        height: size.width * .57,
        child: Shimmer.fromColors(
          baseColor: Colors.white,
          highlightColor: const Color.fromARGB(255, 230, 228, 228),
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) => Row(
                    children: [
                      Card(
                        child: SizedBox(
                          width: size.width * .47,
                          height: size.width * .57,
                          // width: size.width * .4,
                          // height: size.height * .36,
                        ),
                      ),
                      const SizedBox(width: 33),
                    ],
                  )),
          // child: Row(
          //   children: [
          //     Card(
          //       child: SizedBox(
          //         width: size.width * .4,
          //         height: size.height * .36,
          //       ),
          //     ),
          //     const SizedBox(width: 33),
          //     Card(
          //       child: SizedBox(
          //         width: size.width * .4,
          //         height: size.height * .36,
          //       ),
          //     ),
          //     const SizedBox(width: 33),
          //     Card(
          //       child: SizedBox(
          //         width: size.width * .4,
          //         height: size.height * .36,
          //       ),
          //     ),
          //     // const SizedBox(width: 33),
          //     // Card(
          //     //   child: SizedBox(
          //     //     width: size.width * .5,
          //     //     height: size.height * .36,
          //     //   ),
          //     // ),
          //   ],
          // ),
        ),
      ),
    );
  }
}
