import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../app_config/app_config.dart';
import '../../app_config/app_image.dart';
import '../../model/horizontal_profile.dart';
import '../../widget/shared_widgets/bottom_navigation_card_payment_widget.dart';
import '../../widget/shared_widgets/list_profile_horizontal.dart';

class PayWithPaypal extends StatefulWidget {
  const PayWithPaypal({Key? key}) : super(key: key);

  @override
  State<PayWithPaypal> createState() => _PayWithPaypalState();
}

class _PayWithPaypalState extends State<PayWithPaypal> {
  var profileList = [
    ListHorizontalProfile(
      AppConfig.paypal.tr,
      Icons.payment,
      image: AppImage.paypal,
      Image.asset(
        AppImage.paypal,
        width: 25,
        height: 25,
      ),
    ),
    ListHorizontalProfile(
      AppConfig.visa.tr,
      Icons.visibility,
      image: AppImage.visa,
      Image.asset(
        AppImage.visa,
        width: 25,
        height: 25,
      ),
    ),
  ];
  int expandedIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorScheme.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
          child: Column(
            children: [
              // CardProfilePersonalInfo(
              //   userModel: ,
              //   size: size,
              //   colorScheme: colorScheme,
              //   onTap: () {},
              // ),
              const SizedBox(height: 35),
              ListProfileHorizontalWidget(
                isPayScreen: true,
                size: size,
                colorScheme: colorScheme,
                listHorizontalProfile: profileList,
                expandedIndex: expandedIndex,
                onTap: ((index) {
                  setState(() => expandedIndex = index);
                }),
              ),
              BottomNavigationCardPaymentWidget(
                size: size,
                colorScheme: colorScheme,
                expandedIndex: expandedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
