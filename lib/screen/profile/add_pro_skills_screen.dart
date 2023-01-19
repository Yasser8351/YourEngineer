import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

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
            // labelColor: colo,
            unselectedLabelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            indicatorColor: Colors.green,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            tabs: [
              Tab(
                text: "Add Protofilio",
                // child:
                //     TextWidget(title: 'ggg', fontSize: 20, color: Colors.black),
              ),
              Tab(
                text: "Add Skills",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Text("tab 1"),
            AddProtofiloScreen(),
            AddSkillsSreen()
            // Text("tab 2"),
          ],
        ),
      ),
    );
  }
}
