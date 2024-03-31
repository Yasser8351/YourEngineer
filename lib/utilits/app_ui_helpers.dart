import 'package:flutter/material.dart';
import 'package:get/get.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 4.0);
Widget horizontalSpaceLargTiny = SizedBox(width: px5);
const Widget horizontalSpaceSmall = SizedBox(width: 8.0);
Widget horizontalSpaceRegular = SizedBox(width: Get.height * .020566);
const Widget horizontalSpaceMedium = SizedBox(width: 24.0);
Widget horizontalSpaceSemiLarge = SizedBox(width: px32);
const Widget horizontalSpaceLarge = SizedBox(width: 48.0);

/// 1000 pix
/// Get.width * .2778

/// 5.0 pix
final double px5 = Get.height * .00642677;

/// 10.0 pix
final double px10 = Get.height * .0128535;

/// 12.0 pix
final double px12 = Get.height * .015425;

/// 15.0 pix
final double px15 = Get.height * .02;

/// 16.0 pix
final double px16 = Get.height * .020566;

/// 20.0 pix
final double px20 = Get.height * .0258;

/// 25.0 pix
final double px25 = Get.height * .03214;

/// 32.0 pix
final double px32 = Get.height * .0412;

/// 50.0 pix
final double px50 = Get.height * .064268;

/// 90.0 pix
final double px90 = Get.height * .1157;

/// 100.0 pix
final double px100 = Get.height * .12854;
final double px200 = px100 * 2;

///  4.0 pix
Widget verticalSpaceTiny = SizedBox(height: Get.height * .00515);

///  8.0 pix
Widget verticalSpaceSmall = SizedBox(height: Get.height * .01029);

/// 16.0 pix
Widget verticalSpaceRegular = SizedBox(height: Get.height * .020566);

///  24.0 pix
Widget verticalSpaceMedium = SizedBox(height: Get.height * .0309);

///  32.0 pix
Widget verticalSpaceSemiLarge = SizedBox(height: px32);

/// 48 pix
Widget verticalSpaceLarge = SizedBox(height: Get.height * .0617);

/// 64 pix
Widget verticalSpaceXLarge = SizedBox(height: Get.height * .0823);

/// 84 pix
Widget verticalSpaceXXLarge = SizedBox(height: Get.height * .108);

/// 100 pix
Widget verticalSpaceXXXLarge = SizedBox(height: Get.height * .128535);
