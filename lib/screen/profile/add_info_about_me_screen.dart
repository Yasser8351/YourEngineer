import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_config/app_config.dart';
import '../../controller/add_skills_controller.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/text_widget.dart';

// AddSkillsScreen

class AddInfoAboutMeSreen extends StatefulWidget {
  const AddInfoAboutMeSreen({Key? key}) : super(key: key);

  @override
  State<AddInfoAboutMeSreen> createState() => _AddInfoAboutMeSreenState();
}

class _AddInfoAboutMeSreenState extends State<AddInfoAboutMeSreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AddSkillsController controller = Get.put(AddSkillsController());
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 30,
        ),
      )),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: size.height * .03),
            buildTextFormFaild(
              controller.aboutUserController,
              AppConfig.aboutme.tr,
              false,
              TextInputType.text,
              const Icon(Icons.add),
              colorScheme,
              300,
              1,
            ),
            buildTextFormFaild(
              controller.specializationController,
              AppConfig.specialization.tr,
              false,
              TextInputType.text,
              const Icon(Icons.add),
              colorScheme,
              30,
              1,
            ),
            SizedBox(height: size.height * .07),
            ElevatedButton(
              onPressed: () async {
                if (controller.aboutUserController.text.isEmpty ||
                    controller.specializationController.text.isEmpty) {
                  Helper.showError(
                      context: context,
                      subtitle: AppConfig.allFaildRequired.tr);
                  return;
                } else {
                  setState(() => isLoading = true);
                  await controller.addInfoAboutMe(context);
                  setState(() => isLoading = false);
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.height * .03, vertical: 15),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : TextWidget(
                        title: AppConfig.add.tr,
                        fontSize: size.height * .022,
                        color: colorScheme.surface),
              ),
            ),
          ],
        ),
      ),

      ////

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
