import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';

import 'add_protofilo.dart';
import 'add_skills_screen.dart';

class AddPortifolioSkillsScreen extends StatefulWidget {
  const AddPortifolioSkillsScreen({Key? key}) : super(key: key);

  @override
  State<AddPortifolioSkillsScreen> createState() =>
      _AddPortifolioSkillsScreen();
}

class _AddPortifolioSkillsScreen extends State<AddPortifolioSkillsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: Colors.white,
          bottom: TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            indicatorColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            tabs: [
              Tab(
                text: AppConfig.addProtofilo,
              ),
              Tab(
                text: AppConfig.addSkills,
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const AddProtofiloScreen(),
            const AddSkillsSreen(),
          ],
        ),
      ),
    );
  }
}
