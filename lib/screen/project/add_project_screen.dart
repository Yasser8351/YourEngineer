// import 'dart:io';
// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:your_engineer/model/project_model.dart';

import '../../app_config/app_config.dart';
import '../../controller/add_project_controller.dart';
import '../../controller/project_controller.dart';
import '../../debugger/my_debuger.dart';
import '../../enum/all_enum.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/reytry_error_widget.dart';
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
  final AddProjectController addProjectController =
      Get.put(AddProjectController());
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    // File? projectImage;

    Size size = MediaQuery.of(context).size;
    XFile? xfile;

    return Scaffold(
      appBar: _getAppBar(context, widget.isMyProject),
      body: Obx(() {
        if (addProjectController.loadingState.value == LoadingState.initial ||
            addProjectController.loadingState.value == LoadingState.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (addProjectController.loadingState.value ==
            LoadingState.noDataFound) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${addProjectController.message}"),
              ReyTryErrorWidget(
                  title: addProjectController.loadingState.value ==
                          LoadingState.noDataFound
                      ? AppConfig.noData.tr
                      : addProjectController.apiResponse.message,
                  onTap: () {
                    addProjectController.onInit();
                  })
            ],
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * .02),
                buildTextFormFaild(
                  addProjectController.titleController,
                  AppConfig.addTitle,
                  false,
                  TextInputType.text,
                  const Icon(Icons.add),
                  colorScheme,
                  30,
                  1,
                ),
                buildTextFormFaild(
                  addProjectController.descriptionController,
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
                // buildRowList(
                //     context, AppConfig.chooseCategory, colorScheme, Icons.category),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.category),
                    ),
                    Container(
                      width: 300,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: DropdownButton(
                        items: addProjectController.listSubCat
                            .map((e) => DropdownMenuItem(
                                  child: Text(e.name!),
                                  value: e.id,
                                ))
                            .toList(),
                        onChanged: (val) {
                          setState(() {
                            myLog('val', val);
                            addProjectController.selectedCat = val.toString();
                          });
                        },
                        value: addProjectController.selectedCat,
                      ),
                    ),
                  ],
                ),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: buildTextFormFaild(
                          addProjectController.daysController,
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
                Container(
                  width: 300,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: DropdownButton(
                    items: addProjectController.listPriceRange
                        .map((e) => DropdownMenuItem(
                              child: Text(e.rangeName!),
                              value: e.id,
                            ))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        myLog('val', val);
                        addProjectController.selectedPriceRange =
                            val.toString();
                      });
                    },
                    value: addProjectController.selectedPriceRange,
                  ),
                ),

                buildTextFormFaild(
                  addProjectController.skillsController,
                  'Add Skills',
                  false,
                  TextInputType.text,
                  const Icon(Icons.add),
                  colorScheme,
                  300,
                  5,
                ),

                // InkWell(
                //   onTap: () async {
                //     showModalBottomSheet(
                //         context: context,
                //         builder: (context) => Container(
                //               height: 200,
                //               child: Column(
                //                 children: [
                //                   const SizedBox(height: 20),
                //                   Container(
                //                     width: double.infinity,
                //                     alignment: Alignment.center,
                //                     margin: const EdgeInsets.all(10),
                //                     padding: const EdgeInsets.symmetric(
                //                         vertical: 15, horizontal: 10),
                //                     color: Colors.blueAccent,
                //                     child: InkWell(
                //                       onTap: () async {
                //                         xfile = await ImagePicker()
                //                             .pickImage(source: ImageSource.camera);
                //                         Navigator.of(context).pop();
                //                         projectImage = File(xfile!.path);
                //                         setState(() {});
                //                       },
                //                       child: const Text(
                //                         "Chose Image From Camera",
                //                         style: TextStyle(
                //                             fontSize: 15,
                //                             fontWeight: FontWeight.bold,
                //                             color: Colors.white),
                //                       ),
                //                     ),
                //                   ),
                //                   const SizedBox(height: 10),
                //                   Container(
                //                     width: double.infinity,
                //                     alignment: Alignment.center,
                //                     margin: const EdgeInsets.all(10),
                //                     padding: const EdgeInsets.symmetric(
                //                         vertical: 15, horizontal: 10),
                //                     color: Colors.blueAccent,
                //                     child: InkWell(
                //                       onTap: () async {
                //                         XFile? xfile = await ImagePicker()
                //                             .pickImage(source: ImageSource.gallery);
                //                         Navigator.of(context).pop();
                //                         projectImage = File(xfile!.path);
                //                         setState(() {});
                //                       },
                //                       child: const Text(
                //                         "Chose Image From Galary",
                //                         style: TextStyle(
                //                             fontSize: 15,
                //                             fontWeight: FontWeight.bold,
                //                             color: Colors.white),
                //                       ),
                //                     ),
                //                   )
                //                 ],
                //               ),
                //             ));
                //   },
                //   child: Container(
                //     clipBehavior: Clip.antiAlias,
                //     decoration: BoxDecoration(
                //         border: Border.all(
                //           width: 2,
                //           color: Colors.grey.shade300,
                //         ),
                //         borderRadius: BorderRadius.circular(50)),
                //     //
                //     width: size.width * .40,
                //     height: size.height * .20,
                //     child: projectImage != null
                //         ? Image.file(
                //             projectImage!,
                //             fit: BoxFit.fill,
                //           )
                //         : null,
                //   ),
                // ),
                // RangeSlider(
                //   values: projectController.selectedRange,
                //   divisions: 1000,
                //   max: 10000,
                //   min: 25,
                //   labels: RangeLabels(
                //       projectController.selectedRange.start.toString(),
                //       projectController.selectedRange.end.toString()),
                //   onChanged: ((newValue) {
                //     setState(() {
                //       if (projectController.selectedRange.start !=
                //           projectController.selectedRange.start) {
                //         return;
                //       } else {
                //         projectController.isSelectedRange = true;
                //         projectController.selectedRange = newValue;
                //         myLog("projectController. selectedRange======",
                //             "${projectController.selectedRange}");
                //       }
                //     });
                //     //setState(() => {selectedRange = newValue});
                //   }),
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     TextWidget(
                //         title: projectController.selectedRange.start.toString(),
                //         fontSize: 16,
                //         color: colorScheme.primary),
                //     TextWidget(
                //         title: projectController.selectedRange.end.toString(),
                //         fontSize: 16,
                //         color: colorScheme.primary),
                //   ],
                // ),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 25,
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
              myLog("selectedCat.text", "${addProjectController.selectedCat}");
              myLog("selectedPriceRange.text",
                  "${addProjectController.selectedPriceRange}");
              myLog("titleController.text",
                  "${addProjectController.titleController.text}");
              Helper.showError(
                  context: context, subtitle: AppConfig.allFaildRequired.tr);
              return;
            }
            setState(() => isLoading = true);

            bool isAddProject = await addProjectController.addProject(
              context,
            );
            myLog('isAddProject', isAddProject);
            setState(() => isLoading = false);

            if (isAddProject) {
              addProjectController.clearController();
              Helper.showError(
                  context: context, subtitle: "Succesfuly Added Projet");

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
      child: TextField(
        controller: controller,
        keyboardType: inputType,
        maxLength: maxLength,
        maxLines: maxLines,
        scribbleEnabled: true,
        decoration: InputDecoration(hintText: label),
      ),
    );
  }
}
