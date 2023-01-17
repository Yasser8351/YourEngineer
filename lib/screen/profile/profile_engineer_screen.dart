// import 'package:flutter/material.dart';
// import 'package:your_engineer/app_config/app_config.dart';
// import 'package:your_engineer/app_config/app_image.dart';
// import 'package:your_engineer/model/horizontal_profile.dart';

// import '../../widget/shared_widgets/bottom_navigation_card_widget.dart';
// import '../../widget/shared_widgets/card_profile_personal_info.dart';
// import '../../widget/shared_widgets/list_profile_horizontal.dart';

// class ProfileEngineerScreen extends StatefulWidget {
//   const ProfileEngineerScreen({Key? key}) : super(key: key);

//   @override
//   State<ProfileEngineerScreen> createState() => _ProfileEngineerScreenState();
// }

// class _ProfileEngineerScreenState extends State<ProfileEngineerScreen> {
//   var profileList = [
//     ListHorizontalProfile(AppConfig.paypal, Icons.payment,
//         image: AppImage.paypal),
//     ListHorizontalProfile(AppConfig.visa, Icons.visibility,
//         image: AppImage.visa),
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
//                 size: size,
//                 colorScheme: colorScheme,
//                 onTap: () {},
//               ),
//               const SizedBox(height: 35),
//               ListProfileHorizontalWidget(
//                 isPayScreen: true,
//                 size: size,
//                 colorScheme: colorScheme,
//                 listHorizontalProfile: profileList,
//                 expandedIndex: expandedIndex,
//                 onTap: ((index) {
//                   setState(() => expandedIndex = index);
//                 }),
//               ),
//               BottomNavigationCardWidget(
//                 size: size,
//                 colorScheme: colorScheme,
//                 expandedIndex: expandedIndex,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/model/horizontal_profile.dart';
import 'package:your_engineer/model/top_engineer_rating_model.dart';
import 'package:your_engineer/screen/profile/add_protofilo.dart';
import 'package:your_engineer/widget/shared_widgets/bottom_navigation_card_widget.dart';
import 'package:your_engineer/widget/shared_widgets/list_profile_horizontal.dart';

import '../../controller/profile_controller.dart';
import '../../widget/shared_widgets/card_profile_personal_info.dart';

class ProfileEngineerScreen extends StatefulWidget {
  const ProfileEngineerScreen({Key? key, required this.engineerModel})
      : super(key: key);
  final TopEngineerRatingModel engineerModel;

  @override
  State<ProfileEngineerScreen> createState() => _ProfileEngineerScreenState();
}

class _ProfileEngineerScreenState extends State<ProfileEngineerScreen> {
  ProfileController controller = Get.put(ProfileController());
  var profileList = [
    ListHorizontalProfile(AppConfig.personalProfile, Icons.person),
    ListHorizontalProfile(AppConfig.reviews, Icons.star),
    ListHorizontalProfile(AppConfig.businessFair, Icons.badge),
    ListHorizontalProfile(
        AppConfig.paymentHistory, Icons.monetization_on_outlined),
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
                userProfileModel: controller.userProfile,
                isMyProfile: true,
                size: size,
                colorScheme: colorScheme,
                onTap: () {
                  // Navigator.of(context).pushNamed(AppConfig.addProtofilo);
                  //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>))
                  Get.to(() => AddProtofiloScreen());
                },
              ),
              const SizedBox(height: 35),
              ListProfileHorizontalWidget(
                size: size,
                colorScheme: colorScheme,
                listHorizontalProfile: profileList,
                expandedIndex: expandedIndex,
                onTap: ((index) {
                  setState(
                    () => expandedIndex = index,
                    //
                  );
                }),
              ),
              BottomNavigationCardWidget(
                  size: size,
                  colorScheme: colorScheme,
                  expandedIndex: expandedIndex),
            ],
          ),
        ),
      ),
    );
  }
}
