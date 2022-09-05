// ProfileScreen
import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/model/horizontal_profile.dart';
import 'package:your_engineer/widget/card_with_image.dart';

import '../widget/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var profileList = [
    HorizontalProfile(AppConfig.personalProfile, Icons.person),
    HorizontalProfile(AppConfig.reviews, Icons.star),
    HorizontalProfile(AppConfig.businessFair, Icons.badge),
    HorizontalProfile(AppConfig.paymentHistory, Icons.monetization_on_outlined),
  ];
  int expandedIndex = 0;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      //appBar: _getAppBar(context),
      backgroundColor: colorScheme.primary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
          child: Column(
            children: [
              buildCardProfile(size, colorScheme),
              const SizedBox(height: 35),
              buildListProfileHorizontal(colorScheme),
              buildbottomNavigation(size, colorScheme),
            ],
          ),
        ),
      ),
    );
  }

  buildListProfileHorizontal(ColorScheme colorScheme) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
          separatorBuilder: (context, index) => const SizedBox(width: 27),
          scrollDirection: Axis.horizontal,
          itemCount: profileList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() => expandedIndex = index);
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        profileList[index].icon,
                        size: 22,
                        color: colorScheme.onSurface,
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: TextWidget(
                          title: profileList[index].title,
                          fontSize: 17,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 7),
                  expandedIndex == index
                      ? Image.asset(AppImage.divider)
                      // ? const Text(
                      //     "    ___________________________",
                      //     style: TextStyle(color: Colors.white),
                      //   )
                      : const SizedBox(),
                  Divider(
                    color: colorScheme.onSurface,
                  ),
                ],
              ),
            );
          }),
    );
  }

  buildCardProfile(Size size, ColorScheme colorScheme) {
    return CardWithImage(
      height: size.height * .17,
      width: size.width,
      colors: colorScheme.onSurface,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                        title: "Yasser Abubaker",
                        fontSize: 18,
                        color: colorScheme.onSecondary),
                    const SizedBox(height: 4),
                    TextWidget(
                        title: "yasser8351@gmail.com",
                        fontSize: 18,
                        color: colorScheme.onSecondary),
                    const SizedBox(height: 4),
                    TextWidget(
                        title: "Your balance \$200.0 ",
                        fontSize: 18,
                        color: colorScheme.onSecondary),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage(AppImage.img),
                    ),
                    const SizedBox(height: 7),
                    CircleAvatar(
                      radius: 13.0,
                      backgroundColor: colorScheme.primary,
                      child: Icon(
                        Icons.add,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  buildbottomNavigation(Size size, ColorScheme colorScheme) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right: 0, left: 0),
        child: CardWithImage(
          height: size.height * .7,
          width: size.width,
          colors: colorScheme.onSurface,
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 25),
            child: Builder(builder: (context) {
              if (expandedIndex == 1) {
                return buildReviews(
                    colorScheme.background, colorScheme.primary);
              } else if (expandedIndex == 2) {
                return buildBusinessFair(
                    colorScheme.background, colorScheme.primary, size);
              } else if (expandedIndex == 3) {
                return buildPaymentHistory(
                    colorScheme.background, colorScheme.primary);
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    title: "About me",
                    fontSize: 18,
                    color: colorScheme.onSecondary,
                  ),
                  const SizedBox(height: 20),
                  TextWidget(
                    title:
                        "Architect with 2 more than years experience In the field of architectural and interior design.",
                    fontSize: 16,
                    color: colorScheme.onSecondary,
                    isTextStart: true,
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 20),
                  buildRowItem(
                      "Specialization", "Architectural engineer", colorScheme),
                  buildRowItem("Total Reviews", "5.0", colorScheme),
                  buildRowItem("Completed projects", "6", colorScheme),
                  buildRowItem("Projects he works on", "1", colorScheme),
                  buildRowItem(
                      "Date of registration", "12/02/2022", colorScheme),
                  const SizedBox(height: 10),
                  const Divider(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  buildPaymentHistory(Color color, Color color2) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        buildRowReviews(AppConfig.history, AppConfig.seeAll, color, color2),
        const SizedBox(height: 10),
        buildRowItem("Shipped by PayPal", "\$250 -", colorScheme,
            isPadingZero: true),
        const SizedBox(height: 5),
        buildRowItem("yasser8351@gmail.com", "12/07/2022", colorScheme),
        const Divider(),
        const SizedBox(height: 20),
        buildRowItem("Profit from completing", "\$250 +", colorScheme,
            isPadingZero: true),
        const SizedBox(height: 5),
        buildRowItem(
            "an architectural design project", "09/01/2021", colorScheme),
        const Divider(),
        const SizedBox(height: 20),
        buildRowItem("Shipped by PayPal", "\$600 -", colorScheme,
            isPadingZero: true),
        const SizedBox(height: 5),
        buildRowItem("yasser8351@gmail.com", "01/10/2021", colorScheme),
        const Divider(),
      ],
    );
  }

  buildRowItem(String title, String description, ColorScheme colorScheme,
      {bool isPadingZero = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: isPadingZero ? 0 : 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: title,
            fontSize: 16,
            color: colorScheme.onSecondary,
          ),
          TextWidget(
            title: description,
            fontSize: 16,
            color: colorScheme.onSecondary,
          ),
        ],
      ),
    );
  }

  buildRowReviews(
      String title, String description, Color colorScheme, Color colorScheme2) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: title,
            fontSize: 18,
            color: colorScheme,
          ),
          TextWidget(
            title: description,
            fontSize: 18,
            color: colorScheme2,
          ),
        ],
      ),
    );
  }

  buildReviews(Color color, Color color2) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        buildRowReviews(
            "12  ${AppConfig.reviews}", AppConfig.seeAll, color, color2),
        const SizedBox(height: 10),
        buildRowItem("House map design", "completed", colorScheme),
        buildRowItem("Review", "5.0", colorScheme),
        buildRowItem("Project completion date", "12/01/2022", colorScheme),
        const Divider(),
        Padding(
          padding: const EdgeInsets.only(bottom: 15, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(AppImage.img2),
              ),
              const SizedBox(width: 10),
              TextWidget(
                title: "Mohammed Ali \n project owner",
                fontSize: 16,
                color: colorScheme.onSecondary,
              ),
            ],
          ),
        ),
        TextWidget(
          title: "Thank you very much for completing the project",
          fontSize: 16,
          color: colorScheme.onSecondary,
          isTextStart: true,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 15, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 30.0,
                backgroundImage: AssetImage(AppImage.img),
              ),
              const SizedBox(width: 10),
              TextWidget(
                title: "Yasser Abubaker \n engineer",
                fontSize: 16,
                color: colorScheme.onSecondary,
              ),
            ],
          ),
        ),
        TextWidget(
          title: "Thank you Mohammed Ali.",
          fontSize: 16,
          color: colorScheme.onSecondary,
          isTextStart: true,
        ),
      ],
    );
  }

  buildBusinessFair(Color color, Color color2, Size size) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          buildRowReviews(
              "4  ${AppConfig.project}", AppConfig.seeAll, color, color2),
          const SizedBox(height: 10),
          Image.asset(
            AppImage.img5,
            height: 290,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 13),
          buildRowItem(
              "Break design in Saudi Arabia", "12/01/2022", colorScheme),
          const SizedBox(height: 10),
          Image.asset(
            AppImage.img7,
            height: 290,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 13),
          buildRowItem("Gas station design", "07/09/2021", colorScheme),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}













/*
  _getAppBar(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.profile, fontSize: 18, color: Colors.white),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.navigate_before, size: 40),
        color: Colors.white,
      ),
    );
  }

*/

