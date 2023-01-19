import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_image.dart';
import '../../app_config/app_config.dart';
import '../../controller/add_protofilio_controller.dart';
import '../../debugger/my_debuger.dart';
import '../../utilits/helper.dart';
import '../../widget/shared_widgets/text_widget.dart';

class AddProtofiloScreen extends StatefulWidget {
  const AddProtofiloScreen({Key? key, this.isEditProject = false})
      : super(key: key);
  final bool isEditProject;

  @override
  State<AddProtofiloScreen> createState() => _AddProtofiloScreenState();
}

class _AddProtofiloScreenState extends State<AddProtofiloScreen> {
  bool isLoading = false;
  AddProtofilioController controller = Get.put(AddProtofilioController());

  @override
  @override
  void dispose() {
    super.dispose();
  }

  RangeValues selectedRange = const RangeValues(25, 50);
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    controller.day =
        "${controller.dateOfProject.day.toString()}-${controller.dateOfProject.month.toString()}-${controller.dateOfProject.year}";

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: _getAppBar(context, widget.isEditProject),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * .02),
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
              buildTextFormFaild(
                controller.descriptionController,
                AppConfig.addDiscription,
                false,
                TextInputType.text,
                const Icon(Icons.add),
                colorScheme,
                300,
                5,
              ),
              SizedBox(height: size.height * .02),
              TextWidget(
                title: AppConfig.selectImageProject,
                fontSize: 18,
                color: colorScheme.onSecondary,
              ),
              SizedBox(height: size.height * .01),
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Image.asset(
                    AppImage.noData,
                    width: size.width * .3,
                    height: size.width * .4,
                  ),
                ),
              ),
              SizedBox(height: size.height * .03),
              InkWell(
                onTap: () => selectTimePicker(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildRowList(context, AppConfig.dateProject, colorScheme,
                        Icons.calendar_month),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextWidget(
                        title: controller.day!,
                        fontSize: 18,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            if (controller.descriptionController.text.isEmpty ||
                controller.titleController.text.isEmpty ||
                controller.day == null) {
              myLog(
                  "titleController.text", "${controller.titleController.text}");
              myLog("descriptionController.text",
                  "${controller.descriptionController.text}");
              myLog("day.text", "${controller.day}");
              Helper.showError(
                  context: context, subtitle: AppConfig.allFaildRequired.tr);
              return;
            }

            setState(() => isLoading = true);

            bool isAddProject = await controller.addProtofilio(
              context,
            );
            myLog('isAddProject', isAddProject);
            setState(() => isLoading = false);

            if (isAddProject) {
              controller.clearController();
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
                    title: widget.isEditProject
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

  // _getAppBar(BuildContext context, bool isEditProject) {
  //   return AppBar(
  //     title: Padding(
  //       padding: const EdgeInsets.only(top: 10),
  //       child: TextWidget(
  //           title: isEditProject
  //               ? AppConfig.editMyProject
  //               : AppConfig.addProtofilo,
  //           fontSize: 18,
  //           color: Colors.white),
  //     ),
  //     leading: IconButton(
  //       onPressed: () {
  //         Navigator.of(context).pop();
  //       },
  //       icon: const Icon(Icons.navigate_before, size: 40),
  //       color: Colors.white,
  //     ),
  //   );
  // }

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

  Future<void> selectTimePicker(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.dateOfProject,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      controller.dateOfProject = picked;
    });
    if (picked == null && picked == controller.dateOfProject) {
      setState(() {
        controller.dateOfProject = picked;
      });
    }
  }
}
