import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:your_engineer/api/user_auth.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/model/roles_model.dart';
import 'package:your_engineer/model/user_model.dart';
import 'package:your_engineer/widget/shared_widgets/button_widget.dart';

import 'package:your_engineer/widget/shared_widgets/text_faild_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../utilits/helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _comfirmPasswordController = TextEditingController();
  bool _obscureText = true;
  File? myfile;
  XFile? xfile;

  var selectedval;

  late SimpleFontelicoProgressDialog _dialog;
  bool isLoading = false;
  UserAuth userAuth = UserAuth();
  late List<RolesModel> roleList;
  @override
  void initState() {
    isLoading = true;
    super.initState();
    userAuth.getRoles().then((value) => setState((() {
          isLoading = false;
        })));

    _dialog = SimpleFontelicoProgressDialog(
      context: context,
      barrierDimisable: false,
    );
  }

  // File? _storedImage;
  // final ImagePicker _picker = ImagePicker();
  // Future<void> _getImageFromGallery() async {
  //   // SharedPrefUser sharedPrefUser = SharedPrefUser();
  //   final imageFile =
  //       await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

  //   if (imageFile == null) {
  //     return;
  //   }
  //   setState(
  //     () {
  //       _storedImage = File(imageFile.path);
  //       // sharedPrefUser.saveImage(getBase64FormateFile(_storedImage!.path));
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _getAppBar(context),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * .06,
                ),
                child: Column(
                  children: [
                    TextFaildWidget(
                        controller: _firstNameController,
                        label: AppConfig.firstName.tr,
                        obscure: false,
                        icon: IconButton(
                            onPressed: () {
                              clearText(_firstNameController);
                            },
                            icon: const Icon(Icons.close)),
                        inputType: TextInputType.text),
                    SizedBox(height: size.height * .045),
                    TextFaildWidget(
                        controller: _lastNameController,
                        label: AppConfig.lastName.tr,
                        obscure: false,
                        icon: IconButton(
                            onPressed: () {
                              clearText(_lastNameController);
                            },
                            icon: const Icon(Icons.close)),
                        inputType: TextInputType.text),
                    SizedBox(height: size.height * .045),
                    TextFaildWidget(
                        controller: _emailController,
                        label: AppConfig.emal.tr,
                        obscure: false,
                        icon: IconButton(
                            onPressed: () {
                              clearText(_emailController);
                            },
                            icon: const Icon(Icons.close)),
                        inputType: TextInputType.emailAddress),
                    SizedBox(height: size.height * .045),
                    TextFaildWidget(
                        controller: _phoneController,
                        label: AppConfig.phone.tr,
                        obscure: false,
                        icon: IconButton(
                            onPressed: () {
                              clearText(_phoneController);
                            },
                            icon: const Icon(Icons.close)),
                        inputType: TextInputType.number),
                    SizedBox(height: size.height * .045),
                    TextFaildWidget(
                        controller: _passwordController,
                        label: AppConfig.password.tr,
                        icon: IconButton(
                            onPressed: () {
                              showHidePassword();
                            },
                            icon: Icon(
                              _obscureText
                                  ? Icons.remove_red_eye
                                  : Icons.remove_done_rounded,
                            )),
                        obscure: _obscureText,
                        inputType: TextInputType.text),
                    SizedBox(height: size.height * .045),
                    TextFaildWidget(
                        controller: _comfirmPasswordController,
                        label: AppConfig.comfirmPassword.tr,
                        icon: IconButton(
                            onPressed: () {
                              showHidePassword();
                            },
                            icon: const Icon(Icons.remove_red_eye)),
                        obscure: true,
                        inputType: TextInputType.text),
                    SizedBox(height: size.height * .025),
                    // const RadioButtonWidget(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 300,
                          height: 50,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: userAuth.listrole.length,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Radio<int>(
                                          activeColor: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          value: index,
                                          // int.parse(
                                          // "${userAuth.listrole[index].id}"),
                                          groupValue: selectedval,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedval = value;
                                            });
                                            print(
                                                "selectedroole===============${selectedval}");
                                            print(
                                                "selectedroole   iiiiddd===============${userAuth.listrole[selectedval].id}");
                                          }),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          "${userAuth.listrole[index].roleName}",
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                        ),
                      ],
                    ),

                    SizedBox(height: size.height * .045),
////////////////////////////////////////////////////////

                    InkWell(
                      onTap: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                                  height: 200,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20),
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        color: Colors.blueAccent,
                                        child: InkWell(
                                          onTap: () async {
                                            xfile = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.camera);
                                            Navigator.of(context).pop();
                                            myfile = File(xfile!.path);
                                            setState(() {});
                                          },
                                          child: const Text(
                                            "Chose Image From Camera",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        margin: const EdgeInsets.all(10),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 15, horizontal: 10),
                                        color: Colors.blueAccent,
                                        child: InkWell(
                                          onTap: () async {
                                            XFile? xfile = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            Navigator.of(context).pop();
                                            myfile = File(xfile!.path);
                                            setState(() {});
                                          },
                                          child: const Text(
                                            "Chose Image From Galary",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(50)),
                        //
                        width: size.width * .40,
                        height: size.height * .20,
                        child: myfile != null
                            ? Image.file(
                                myfile!,
                                fit: BoxFit.fill,
                              )
                            : null,
                      ),
                    ),
                    // ),

                    SizedBox(height: size.height * .045),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ButtonWidget(
                            title: AppConfig.signUp.tr,
                            color: colorScheme.primary,
                            onTap: () async {
                              // _showDialog('');

                              // validateData();
                              if (_emailController.text.isEmpty ||
                                  _firstNameController.text.isEmpty ||
                                  _lastNameController.text.isEmpty ||
                                  _passwordController.text.isEmpty ||
                                  _phoneController.text.isEmpty ||
                                  myfile == null) {
                                Helper.showError(
                                    context: context,
                                    subtitle: AppConfig.allFaildRequired.tr);
                                return;
                              }
                              setState(() => isLoading = true);
                              UserModel userModel = UserModel(
                                token: '',
                                lastName: _lastNameController.text,
                                fistName: _firstNameController.text,
                                fullName: _firstNameController.text +
                                    _lastNameController.text,
                                email: _emailController.text,
                                phone: _phoneController.text,
                                userId: 0,
                                userImage: myfile.toString(),
                              );

                              bool isSignup = await userAuth.userSignup(
                                context,
                                userModel,
                                _passwordController.text,
                                selectedval,
                                myfile!,
                              );
                              myLog('isSignup', isSignup);
                              setState(() => isLoading = false);

                              if (isSignup) {
                                Navigator.of(context)
                                    .pushNamed(AppConfig.login);
                                Helper.showseuess(
                                    context: context,
                                    subtitle: "تم انشاء حسابك بنجاح");
                                //userSignup sucssufuly
                                // ignore: use_build_context_synchronously

                              } else {
                                //userSignup faild try again later

                              }
                            },
                          ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextWidget(
                            title: "  ${AppConfig.agreeTotermsOfServices.tr} "
                                "\n  ${AppConfig.termsOfServices.tr} ",
                            fontSize: 15,
                            color: colorScheme.onSecondary,
                          ),
                          // TextWidget(
                          //   title: AppConfig.termsOfServices.tr,
                          //   fontSize: 15,
                          //   color: colorScheme.primary,
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.signUpWithEmail.tr,
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

  void _showDialog(String message) async {
    _dialog.show(
      message: AppConfig.loading,
      indicatorColor: Theme.of(context).colorScheme.primary,
    );
  }

  void validateData() {
    if (_emailController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        myfile != null) {
      Helper.showError(context: context, subtitle: "جميع الحقول مطلوبة");
      return;
    }
  }

  void showHidePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
