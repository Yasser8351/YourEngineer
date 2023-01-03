import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/model/project_model.dart';

import '../../app_config/app_config.dart';
import '../../controller/project_controller.dart';
import '../../debugger/my_debuger.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/text_widget.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen(
      {Key? key, required this.projectModel, this.isMyProject = false})
      : super(key: key);
  final ProjectModel projectModel;
  final bool isMyProject;

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  TextEditingController daysController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final ProjectController projectController = Get.find();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initalControllers();
  }

  initalControllers() {
    // log(widget.projectModel.titleProject);
    // titleController.text = widget.projectModel.titleProject;
    // descriptionController.text = widget.projectModel.descriptionProject;
    // daysController.text = widget.projectModel.titleProject;
  }

  @override
  void dispose() {
    super.dispose();
  }

  disposeControllers() {
    titleController.dispose();
    descriptionController.dispose();
    daysController.dispose();
  }

  RangeValues selectedRange = const RangeValues(25, 50);
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context, widget.isMyProject),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * .02),
            buildTextFormFaild(
              titleController,
              AppConfig.addTitle,
              false,
              TextInputType.text,
              const Icon(Icons.add),
              colorScheme,
              30,
              1,
            ),
            buildTextFormFaild(
              descriptionController,
              AppConfig.addDiscription,
              false,
              TextInputType.text,
              const Icon(Icons.add),
              colorScheme,
              300,
              5,
            ),
            TextWidget(
              title: AppConfig.chooseCategory,
              fontSize: 16,
              color: colorScheme.secondary,
              isTextStart: true,
            ),
            buildRowList(
                context, AppConfig.chooseCategory, colorScheme, Icons.category),
            const SizedBox(height: 11),
            TextWidget(
              title: AppConfig.projectDelivered,
              fontSize: 16,
              color: colorScheme.secondary,
              isTextStart: true,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                buildRowList(context, AppConfig.delivaryTime, colorScheme,
                    Icons.timelapse),
                SizedBox(
                  width: 150,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: buildTextFormFaild(
                      daysController,
                      "days",
                      false,
                      TextInputType.number,
                      const Icon(Icons.data_array_sharp),
                      colorScheme,
                      20,
                      1,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            TextWidget(
              title: AppConfig.yourBudget,
              fontSize: 16,
              color: colorScheme.secondary,
              isTextStart: true,
            ),
            buildRowList(context, AppConfig.budget, colorScheme,
                Icons.attach_money_outlined),
            RangeSlider(
              values: selectedRange,
              divisions: 1000,
              max: 10000,
              min: 25,
              labels: RangeLabels(
                  selectedRange.start.toString(), selectedRange.end.toString()),
              onChanged: ((newValue) {
                setState(() {
                  if (selectedRange.start != selectedRange.start) {
                    return;
                  } else {
                    selectedRange = newValue;
                  }
                });
                //setState(() => {selectedRange = newValue});
              }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                    title: selectedRange.start.toString(),
                    fontSize: 16,
                    color: colorScheme.primary),
                TextWidget(
                    title: selectedRange.end.toString(),
                    fontSize: 16,
                    color: colorScheme.primary),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 25,
        ),
        child: ElevatedButton(
          onPressed: () async {
            //in this method will
            //send Project to Server
            // if (daysController.text.isEmpty ||
            //     descriptionController.text.isEmpty ||
            //     titleController.text.isEmpty) {
            //   Helper.showError(
            //       context: context, subtitle: AppConfig.allFaildRequired.tr);
            //   return;
            // }
            setState(() => isLoading = true);

            bool isAddProject = await projectController.addProject(
              context,
              "",
              "",
            );
            myLog('isAddProject', isAddProject);
            setState(() => isLoading = false);

            if (isAddProject) {
              clearController();
              //userSignup sucssufuly
              // ignore: use_build_context_synchronously
              // Navigator.of(context).pushNamed(AppConfig.login);
            } else {
              Helper.showError(
                  context: context, subtitle: "can not add projet");
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : TextWidget(
                    title: widget.isMyProject
                        ? AppConfig.editMyProject
                        : AppConfig.submitYourProject,
                    fontSize: 20,
                    color: colorScheme.surface),
          ),
        ),
      ),
    );
  }

  buildRowList(context, String title, ColorScheme colorScheme, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 25,
          color: colorScheme.secondary,
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextWidget(
            title: title,
            fontSize: 18,
            color: colorScheme.onSecondary,
            isTextStart: true,
          ),
        ),
      ],
    );
  }

  _getAppBar(BuildContext context, bool isMyProject) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextWidget(
            title: isMyProject
                ? AppConfig.editMyProject
                : AppConfig.addProjectScreen,
            fontSize: 18,
            color: Colors.white),
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
    return Theme(
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
        keyboardType: inputType,
        maxLength: maxLength,
        maxLines: maxLines,
        scribbleEnabled: true,
        decoration: InputDecoration(hintText: label),
      ),
    );
  }

  void clearController() {
    daysController.clear();
    descriptionController.clear();
    titleController.clear();
  }
}
