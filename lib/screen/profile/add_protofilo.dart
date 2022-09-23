import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_image.dart';
import '../../app_config/app_config.dart';
import '../../widget/shared_widgets/text_widget.dart';

class AddProtofiloScreen extends StatefulWidget {
  const AddProtofiloScreen({Key? key, this.isEditProject = false})
      : super(key: key);
  final bool isEditProject;

  @override
  State<AddProtofiloScreen> createState() => _AddProtofiloScreenState();
}

class _AddProtofiloScreenState extends State<AddProtofiloScreen> {
  TextEditingController daysController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime dateOfProject = DateTime.now();

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
    String day =
        "${dateOfProject.day.toString()}-${dateOfProject.month.toString()}-${dateOfProject.year}";

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context, widget.isEditProject),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        title: day,
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
          onPressed: () {
            //in this method will
            //send Project to Server
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: TextWidget(
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

  _getAppBar(BuildContext context, bool isEditProject) {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: TextWidget(
            title: isEditProject
                ? AppConfig.editMyProject
                : AppConfig.addProtofilo,
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

  Future<void> selectTimePicker(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateOfProject,
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );
    if (picked == null) {
      return;
    }
    setState(() {
      dateOfProject = picked;
    });
    if (picked == null && picked == dateOfProject) {
      setState(() {
        dateOfProject = picked;
      });
    }
  }
}
