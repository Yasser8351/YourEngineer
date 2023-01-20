import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/app_config/app_image.dart';
import 'package:your_engineer/screen/forgot_password_screen.dart';
import 'package:your_engineer/screen/tab_screen.dart';
import 'package:your_engineer/utilits/helper.dart';
import 'package:your_engineer/widget/shared_widgets/button_widget.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import 'package:your_engineer/widget/shared_widgets/text_faild_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../api/user_auth.dart';
import '../debugger/my_debuger.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late SimpleFontelicoProgressDialog _dialog;
  bool isLoading = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();

    _dialog = SimpleFontelicoProgressDialog(
      context: context,
      barrierDimisable: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: colorScheme.primary,
      //   leading: const SizedBox(),
      // ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          color: colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                //border: Border.all(color: colors),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      maxRadius: 40,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      backgroundImage: const AssetImage(
                        AppImage.logo,
                      ),
                      // child: const Text(
                      //   "Logo",
                      //   style: TextStyle(color: Colors.white),
                      // ),
                    ),
                    const SizedBox(height: 30),
                    TextFaildWidget(
                        controller: _emailController,
                        label: AppConfig.emal.tr,
                        obscure: false,
                        icon: IconButton(
                          onPressed: () {
                            clearText(_emailController);
                          },
                          icon: const Icon(Icons.close),
                        ),
                        inputType: TextInputType.emailAddress),
                    SizedBox(height: size.height * .05),
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
                    SizedBox(height: size.height * .1),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ButtonWidget(
                            title: AppConfig.login.tr,
                            color: colorScheme.primary,
                            onTap: () async {
                              // validateData();

                              if (_emailController.text.isEmpty ||
                                  _passwordController.text.isEmpty) {
                                Helper.showError(
                                    context: context,
                                    subtitle: AppConfig.allFaildRequired.tr);
                                return;
                              }

                              setState(() => isLoading = true);
                              UserAuth userAuth = UserAuth();
                              bool isSignup = await userAuth.userSignIn(
                                context,
                                _emailController.text,
                                _passwordController.text,
                              );
                              setState(() => isLoading = false);

                              // _dialog.hide();
                              myLog('isSignup', isSignup);
                              if (isSignup) {
                                Get.off(() => TabScreen());
                              }
                            },
                          ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => Get.to(() => ForgotPasswordScreen()),
                        child: TextWidget(
                            title: AppConfig.forgetPassword.tr,
                            fontSize: 15,
                            color: colorScheme.primary),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                        onTap: () =>
                            Navigator.of(context).pushNamed(AppRouting.signUp),
                        child: TextWidget(
                            title: AppConfig.signUp.tr,
                            fontSize: 15,
                            color: colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
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
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
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
