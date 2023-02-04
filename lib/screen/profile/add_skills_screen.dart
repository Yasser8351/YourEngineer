import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_config/app_config.dart';
import '../../controller/add_skills_controller.dart';
import '../../debugger/my_debuger.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/text_widget.dart';

// AddSkillsScreen

class AddSkillsSreen extends StatefulWidget {
  const AddSkillsSreen({Key? key}) : super(key: key);

  @override
  State<AddSkillsSreen> createState() => _AddSkillsSreenState();
}

class _AddSkillsSreenState extends State<AddSkillsSreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AddSkillsController controller = Get.put(AddSkillsController());
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * .03),
          // TextWidget(
          //   title: "Add Your Skills",
          //   fontSize: 18,
          //   color: colorScheme.onSecondary,
          // ),
          buildTextFormFaild(
            controller.titleController,
            AppConfig.addTitle,
            false,
            TextInputType.text,
            const Icon(Icons.add),
            colorScheme,
            30,
            1,
          ),
        ],
      ),

      ////
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 25,
        ),
        child: ElevatedButton(
          onPressed: () async {
            //in this method will
            //send Project to Server
            if (controller.titleController.text.isEmpty) {
              myLog(
                  "titleController.text", "${controller.titleController.text}");

              Helper.showError(
                  context: context, subtitle: AppConfig.allFaildRequired.tr);
              return;
            } else {
              setState(() => isLoading = true);

              bool isAddProject = await controller.addSkills(
                context,
              );
              myLog('isAddProject', isAddProject);

              setState(() => isLoading = false);
              if (isAddProject) {
                controller.clearController();
                Helper.showseuess(
                    context: context, subtitle: "Succesfuly Added Projet");
              } else {
                Helper.showError(
                    context: context, subtitle: "can not add projet");
              }
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : TextWidget(
                    title: AppConfig.submitYourProject,
                    fontSize: 20,
                    color: colorScheme.surface),
          ),
        ),
      ),

      ///
    );
  }
}

buildTextFormFaild(
  TextEditingController controller,
  String label,
  bool obscure,
  TextInputType inputType,
  Icon icon,
  ColorScheme colorScheme,
  int maxLength,
  int maxLines,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Theme(
      data: ThemeData(
        colorScheme: ColorScheme(
          primary: colorScheme.primary,
          onPrimary: Colors.black,
          secondary: Colors.black,
          onSecondary: Colors.white,
          brightness: Brightness.light,
          background: Colors.black,
          onBackground: Colors.black,
          error: Colors.black,
          onError: Colors.black,
          surface: Colors.black,
          onSurface: Colors.black,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        maxLength: maxLength,
        maxLines: maxLines,
        scribbleEnabled: true,
        textAlign: TextAlign.end,
        decoration: InputDecoration(hintText: label),
      ),
    ),
  );
}
