// // ProfileScreen
// import 'package:flutter/material.dart';
// import 'package:your_engineer/app_config/app_config.dart';
// import 'package:your_engineer/model/horizontal_profile.dart';
// import 'package:your_engineer/model/top_engineer_rating_model.dart';
// import 'package:your_engineer/widget/shared_widgets/bottom_navigation_card_widget.dart';
// import 'package:your_engineer/widget/shared_widgets/list_profile_horizontal.dart';

// import '../../widget/shared_widgets/card_profile_personal_info.dart';

// class ProfileUserScreen extends StatefulWidget {
//   const ProfileUserScreen({Key? key, required this.engineerModel})
//       : super(key: key);
//   final TopEngineerRatingModel engineerModel;

//   @override
//   State<ProfileUserScreen> createState() => _ProfileUserScreenState();
// }

// class _ProfileUserScreenState extends State<ProfileUserScreen> {
//   var profileList = [
//     ListHorizontalProfile(AppConfig.personalProfile, Icons.person),
//     ListHorizontalProfile(AppConfig.reviews, Icons.star),
//     ListHorizontalProfile(AppConfig.businessFair, Icons.badge),
//     ListHorizontalProfile(
//         AppConfig.paymentHistory, Icons.monetization_on_outlined),
//   ];
//   int expandedIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     ColorScheme colorScheme = Theme.of(context).colorScheme;
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: colorScheme.primary,
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
//           child: Column(
//             children: [
//               CardProfilePersonalInfo(
//                 isMyProfile: true,
//                 size: size,
//                 colorScheme: colorScheme,
//                 onTap: () {
//                   Navigator.of(context).pushNamed(AppConfig.addProtofilo);
//                 },
//               ),
//               const SizedBox(height: 35),
//               ListProfileHorizontalWidget(
//                 size: size,
//                 colorScheme: colorScheme,
//                 listHorizontalProfile: profileList,
//                 expandedIndex: expandedIndex,
//                 onTap: ((index) {
//                   setState(() => expandedIndex = index);
//                 }),
//               ),
//               BottomNavigationCardWidget(
//                   size: size,
//                   colorScheme: colorScheme,
//                   expandedIndex: expandedIndex),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/model/horizontal_profile.dart';

import '../../model/top_engineer_rating_model.dart';
import '../../widget/shared_widgets/bottom_navigation_card_widget.dart';
import '../../widget/shared_widgets/card_profile_personal_info.dart';
import '../../widget/shared_widgets/list_profile_horizontal.dart';
import 'add_protofilo.dart';

class ProfileUserScreen extends StatefulWidget {
  const ProfileUserScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUserScreen> createState() => _ProfileUserScreenState();
}

class _ProfileUserScreenState extends State<ProfileUserScreen> {
  var profileList = [
    ListHorizontalProfile(AppConfig.paypal, Icons.payment,
        image: AppImage.paypal),
    ListHorizontalProfile(AppConfig.visa, Icons.visibility,
        image: AppImage.visa),
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
              CardProfilePersonalInfo(
                size: size,
                colorScheme: colorScheme,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AddProtofiloScreen()));
                },
              ),
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
              BottomNavigationCardWidget(
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
