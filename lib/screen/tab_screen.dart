import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:your_engineer/screen/project_screen.dart';

import '../app_config/app_config.dart';
import 'all_settings/settings_screen.dart';
import 'chat/chat_screen.dart';
import 'home_screen.dart';

class TabScreen extends StatefulWidget {
  TabScreen({Key? key, this.selectIndex = 0}) : super(key: key);
  int selectIndex;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  // int _selectIndex = 0;
  DateTime timeBackPressed = DateTime.now();

  void _navigateBottomBar(int index) {
    setState(() {
      widget.selectIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomeScreen(),
    const ChatScreen(),
    const ProjectScreen(),
    const SettingsScreen(),
  ];

  @override
  // void initState() {
  //   super.initState();
  //   getUserData();
  // }

  // getUserData() async {
  //   SharedPrefUser sharedPrefUser = SharedPrefUser();
  //   await sharedPrefUser.getUserData();
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: WillPopScope(
              onWillPop: () async {
                final differenc = DateTime.now().difference(timeBackPressed);
                final exitApp = differenc >= const Duration(seconds: 2);

                timeBackPressed = DateTime.now();

                if (exitApp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Theme.of(context).primaryColor,
                      duration: const Duration(seconds: 2),
                      content: const Text(
                        AppConfig.exitApp,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  );
                  return false;
                } else {
                  return true;
                }
              },
              child: Scaffold(
                body: _pages[widget.selectIndex],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: widget.selectIndex,
                  onTap: _navigateBottomBar,
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: AppConfig.home.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat_bubble_outline_rounded),
                      label: AppConfig.chat.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.content_paste_go),
                      label: AppConfig.project.tr,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: AppConfig.settings.tr,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
