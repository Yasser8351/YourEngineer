// import 'dart:io';
// import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_engineer/screen/tab_screen.dart';
import 'package:your_engineer/utilits/app_ui_helpers.dart';
import 'package:your_engineer/widget/shared_widgets/text_faild_input.dart';

import '../../app_config/app_config.dart';
import '../../controller/add_project_controller.dart';
import '../../debugger/my_debuger.dart';
import '../../enum/all_enum.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/text_widget.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key, this.isMyProject = false})
      : super(key: key);
  final bool isMyProject;

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final AddProjectController addProjectController =
      Get.put(AddProjectController());
  bool isLoading = false;
  bool isLoadingSubCategory = false;
  File? myfile;
  XFile? xfile;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // File? projectImage;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _getAppBar(context, widget.isMyProject),
      body: Obx(() {
        if (addProjectController.loadingState.value == LoadingState.initial ||
            addProjectController.loadingState.value == LoadingState.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: px5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * .02),
                  buildTextFormFaild(
                    addProjectController.titleController,
                    AppConfig.addTitle.tr,
                    false,
                    TextInputType.text,
                    const Icon(Icons.add),
                    colorScheme,
                    30,
                    1,
                  ),
                  buildTextFormFaild(
                    addProjectController.descriptionController,
                    AppConfig.addDiscription.tr,
                    false,
                    TextInputType.text,
                    const Icon(Icons.add),
                    colorScheme,
                    300,
                    5,
                  ),
                  ///////////////////////////////////////
                  ///
                  // TextWidget(
                  //   title: AppConfig.chooseCategory.tr,
                  //   fontSize: px16,
                  //   color: colorScheme.secondary,
                  //   isTextStart: true,
                  // ),
                  // buildRowList(
                  //     context, AppConfig.chooseCategory, colorScheme, Icons.category),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.app_badge),
                        // child: Icon(Icons.category),
                      ),
                      Container(
                        width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: DropdownButton(
                          hint: Text(
                            AppConfig.selectCategory.tr,
                            style: TextStyle(color: Colors.grey),
                          ),
                          items: addProjectController.listPopulerServices
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.titleServices),
                                    value: e.id,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              addProjectController.selectedCat = val.toString();
                              isLoadingSubCategory = true;
                              myLog('val', val);
                              addProjectController
                                  .getsubCatigory(val.toString())
                                  .then((value) => {
                                        setState(() {
                                          isLoadingSubCategory = false;
                                        })
                                      });
                            });
                          },
                          value: addProjectController.selectedCat,
                        ),
                      ),
                    ],
                  ),

                  /////////////////////////////////////////////////
                  ///
                  verticalSpaceMedium,
                  // TextWidget(
                  //   title: "Choose Sub Category",
                  //   fontSize: px16,
                  //   color: colorScheme.secondary,
                  //   isTextStart: true,
                  // ),
                  // buildRowList(
                  //     context, AppConfig.chooseCategory, colorScheme, Icons.category),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(CupertinoIcons.app_badge),
                      ),
                      Container(
                        width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: isLoadingSubCategory
                            ? Center(child: CircularProgressIndicator())
                            : DropdownButton(
                                hint: Text(
                                  AppConfig.selectSubCategory.tr,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                items: addProjectController.listSubCat
                                    .map((e) => DropdownMenuItem(
                                          child: Text(e.name!),
                                          value: e.id,
                                        ))
                                    .toList(),
                                onChanged: (val) {
                                  setState(() {
                                    addProjectController.selectedSubCat =
                                        val.toString();
                                  });
                                },
                                value: addProjectController.selectedSubCat,
                              ),
                      ),
                    ],
                  ),
                  verticalSpaceMedium,

                  const SizedBox(height: 11),
                  TextWidget(
                    title: AppConfig.projectDelivered.tr,
                    fontSize: px16,
                    color: colorScheme.secondary,
                    isTextStart: true,
                  ),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildRowList(context, AppConfig.delivaryTime.tr,
                          colorScheme, Icons.timelapse),
                      SizedBox(
                        width: 150,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 0),
                          child: buildTextFormFaild(
                            addProjectController.daysController,
                            AppConfig.days.tr,
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
                    title: AppConfig.yourBudget.tr,
                    fontSize: px16,
                    color: colorScheme.secondary,
                    isTextStart: true,
                  ),

                  Row(
                    children: [
                      buildRowList(context, AppConfig.budget.tr, colorScheme,
                          Icons.attach_money_outlined),
                      Container(
                        width: px200,
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: DropdownButton(
                          hint: Text(
                            AppConfig.budget.tr,
                            style: TextStyle(color: Colors.grey),
                          ),
                          items: addProjectController.listPriceRange
                              .map((e) => DropdownMenuItem(
                                    child: Text(e.rangeName!),
                                    value: e.id,
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              addProjectController.selectedPriceRange =
                                  val.toString();
                            });
                          },
                          value: addProjectController.selectedPriceRange,
                        ),
                      ),
                    ],
                  ),

                  buildTextFormFaild(
                    addProjectController.skillsController,
                    AppConfig.addSkills.tr,
                    false,
                    TextInputType.text,
                    const Icon(Icons.add),
                    colorScheme,
                    300,
                    5,
                  ),
                  verticalSpaceMedium,
                  InkWell(
                    onTap: () async {
                      XFile? xfile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      myfile = File(xfile!.path);
                      setState(() {});
                    },
                    child: Center(
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        //
                        width: size.width * .60,
                        height: size.height * .15,
                        child: myfile != null
                            ? Image.file(
                                myfile!,
                                fit: BoxFit.fill,
                              )
                            : Center(child: Text(AppConfig.attachFile.tr)),
                      ),
                    ),
                  ),
                  verticalSpaceMedium,
                  bottomNavigationBar(colorScheme),
                  verticalSpaceMedium,
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  bottomNavigationBar(colorScheme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: px10,
          horizontal: px25,
        ),
        child: ElevatedButton(
          onPressed: () async {
            //in this method will
            //send Project to Server
            if (addProjectController.daysController.text.isEmpty ||
                addProjectController.descriptionController.text.isEmpty ||
                addProjectController.titleController.text.isEmpty ||
                addProjectController.selectedCat == null ||
                addProjectController.selectedPriceRange == null) {
              Helper.showError(
                  context: context, subtitle: AppConfig.allFaildRequired.tr);
              return;
            }
            setState(() => isLoading = true);

            bool isAddProject = await addProjectController.addProject(
              context,
              myfile,
            );
            setState(() => isLoading = false);

            if (isAddProject) {
              addProjectController.clearController();
              showseuessToast(AppConfig.addedProjetSuccesfuly.tr);

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => TabScreen(selectIndex: 2)));
            } else {
              // showseuessToast(addProjectController.message);
            }
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: px32, vertical: px16),
            child: isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : TextWidget(
                    title: widget.isMyProject
                        ? AppConfig.editMyProject.tr
                        : AppConfig.submitYourProject.tr,
                    fontSize: px16,
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
                ? AppConfig.editMyProject.tr
                : AppConfig.addProjectScreen.tr,
            fontSize: 18,
            color: Colors.white),
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
          // addProjectController.back();
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
      child: TextFaildInput(
        padingTop: px10,
        padingRigth: px16,
        padingLeft: px16,
        controller: controller,
        inputType: inputType,
        maxLength: maxLength,
        inputAction: TextInputAction.next,
        maxLines: maxLines,
        // label: label,
        hint: label,
        // scribbleEnabled: true,
        // decoration: InputDecoration(hintText: label),
      ),
      // child: TextField(
      //   controller: controller,
      //   keyboardType: inputType,
      //   maxLength: maxLength,
      //   textInputAction: TextInputAction.next,
      //   maxLines: maxLines,
      //   scribbleEnabled: true,
      //   decoration: InputDecoration(hintText: label),
      // ),
    );
  }
}
