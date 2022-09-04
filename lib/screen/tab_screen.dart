import 'package:flutter/material.dart';
import 'package:your_engineer/screen/project_screen.dart';

import '../app_config/app_config.dart';
import 'chat_screen.dart';
import 'home_screen.dart';
import 'settings_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectIndex = 3;
  DateTime timeBackPressed = DateTime.now();

  void _navigateBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  final List<Widget> _pages = [
    const SettingsScreen(),
    const ProjectScreen(),
    const ChatScreen(),
    const HomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
  }

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
                body: _pages[_selectIndex],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectIndex,
                  onTap: _navigateBottomBar,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.settings),
                      label: AppConfig.settings,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.content_paste_go),
                      label: AppConfig.project,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.chat_bubble_outline_rounded),
                      label: AppConfig.chat,
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: AppConfig.home,
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
