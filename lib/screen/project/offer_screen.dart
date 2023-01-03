import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/model/project_model.dart';
import 'package:your_engineer/widget/shared_widgets/button_widget.dart';

import '../../app_config/app_config.dart';
import '../../model/offers_engineer_model.dart';
import '../../widget/list_offers_engineer_widget.dart';
import '../../widget/shared_widgets/text_widget.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen(
      {Key? key, required this.projectModel, this.isMyProject = false})
      : super(key: key);
  final Project projectModel;
  final bool isMyProject;

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  TextEditingController daysController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  List<OffersEngineerModel> listOffersEngineer = [
    OffersEngineerModel(
        nameEngineer: "nameEngineer",
        engineerspecialist: "engineerspecialist",
        offersDetails:
            "Peace be upon you. I am Eng. Hassan al-Nakhal, a civil engineer. I work in the field of civil engineering, quantification, and preparation of extracts. The work will be delivered to you in a notebook. Limited, provided you have...",
        offersDate: "2 hours",
        imageEngineer: AppImage.img11,
        engineerRating: 3.5),
    OffersEngineerModel(
        nameEngineer: "nameEngineer",
        engineerspecialist: "engineerspecialist",
        offersDetails:
            "Peace, mercy, and blessings of God be upon you. Engineer Taha has five years of experience in the work of the technical office in the largest projects in the Arab Republic of Egypt, the last of which is the Monte Galala project, Ain Sokhna, attached to...",
        offersDate: "3 hours",
        imageEngineer: AppImage.img4,
        engineerRating: 4.5),
    OffersEngineerModel(
        nameEngineer: "nameEngineer",
        engineerspecialist: "engineerspecialist",
        offersDetails:
            "Peace, mercy, and blessings of God be upon you. Engineer Taha has five years of experience in the work of the technical office in the largest projects in the Arab Republic of Egypt, the last of which is the Monte Galala project, Ain Sokhna, attached to...",
        offersDate: "4 hours",
        imageEngineer: AppImage.img12,
        engineerRating: 5),
  ];

  @override
  void initState() {
    super.initState();
  }

  initalControllers() {
    titleController.text = widget.projectModel.titleProject;
    descriptionController.text = widget.projectModel.descriptionProject;
    daysController.text = widget.projectModel.titleProject;
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * .02),
              TextWidget(
                  title: widget.projectModel.titleProject,
                  fontSize: size.height * .025,
                  color: colorScheme.primary),
              SizedBox(height: size.height * .02),
              TextWidget(
                  title: "${AppConfig.projectDetails} :",
                  fontSize: size.height * .025,
                  color: colorScheme.background),
              SizedBox(height: size.height * .02),
              TextWidget(
                title: widget.projectModel.descriptionProject,
                fontSize: size.height * .025,
                color: colorScheme.onSecondary,
                isTextStart: true,
              ),
              SizedBox(height: size.height * .01),

              const Divider(),
              SizedBox(height: size.height * .03),
              TextWidget(
                title: AppConfig.addOffer,
                fontSize: size.height * .025,
                color: colorScheme.onSecondary,
                isTextStart: true,
              ),
              SizedBox(height: size.height * .03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(
                    title: "\$",
                    fontSize: size.width * .07,
                    color: colorScheme.primary,
                    isTextStart: true,
                  ),
                  SizedBox(width: size.width * .03),
                  buildTextFormFaild(
                    titleController,
                    AppConfig.price,
                    false,
                    TextInputType.number,
                    const Icon(Icons.add),
                    colorScheme,
                    size.width * .3,
                    size.height * .04,
                  ),
                  const Spacer(),
                  TextWidget(
                    title: AppConfig.days,
                    fontSize: size.width * .05,
                    color: colorScheme.primary,
                    isTextStart: true,
                  ),
                  SizedBox(width: size.width * .03),
                  buildTextFormFaild(
                    titleController,
                    AppConfig.days,
                    false,
                    TextInputType.number,
                    const Icon(Icons.add),
                    colorScheme,
                    size.width * .3,
                    size.height * .04,
                  ),
                ],
              ),
              SizedBox(height: size.height * .03),
              buildTextFormFaildDescription(
                titleController,
                AppConfig.descreiption,
                false,
                TextInputType.text,
                const Icon(Icons.add),
                colorScheme,
              ),
              SizedBox(height: size.height * .02),
              ButtonWidget(
                  title: AppConfig.addOffer,
                  color: colorScheme.primary,
                  onTap: () {}),
              SizedBox(height: size.height * .02),

              const Divider(),
              TextWidget(
                title: AppConfig.allOffer,
                fontSize: size.height * .025,
                color: colorScheme.onSecondary,
                isTextStart: true,
              ),

              ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                separatorBuilder: (context, index) =>
                    SizedBox(height: size.height * .02),
                itemCount: listOffersEngineer.length,
                itemBuilder: (context, index) => ListOffersEngineerWidget(
                  colorScheme: colorScheme,
                  size: size,
                  offersEngineerModel: listOffersEngineer[index],
                ),
              )
              // ListOffersEngineerWidget(),
            ],
          ),
        ),
      ),
      /*  
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
                title: widget.isMyProject
                    ? AppConfig.editMyProject
                    : AppConfig.submitYourProject,
                fontSize: 20,
                color: colorScheme.surface),
          ),
        ),
      ),
   */
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
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.offerScreen, fontSize: 18, color: Colors.white),
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
    double width,
    double height,
  ) {
    return SizedBox(
      width: width,
      height: height,
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
          keyboardType: inputType,
          scribbleEnabled: true,
          decoration: InputDecoration(hintText: label),
          // maxLength: 300,
        ),
      ),
    );
  }

  buildTextFormFaildDescription(
    TextEditingController controller,
    String label,
    bool obscure,
    TextInputType inputType,
    Icon icon,
    ColorScheme colorScheme,
  ) {
    return SizedBox(
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
          keyboardType: inputType,
          scribbleEnabled: true,
          decoration: InputDecoration(hintText: label),
          maxLength: 300,
          maxLines: 3,
        ),
      ),
    );
  }
}
