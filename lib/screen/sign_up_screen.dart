import 'package:flutter/material.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:your_engineer/api/user_auth.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/debugger/my_debuger.dart';
import 'package:your_engineer/widget/shared_widgets/button_widget.dart';
import 'package:your_engineer/widget/shared_widgets/radio_button_widget.dart';

import 'package:your_engineer/widget/shared_widgets/text_faild_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

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

  late SimpleFontelicoProgressDialog _dialog;

  @override
  void initState() {
    super.initState();

    _dialog = SimpleFontelicoProgressDialog(
      context: context,
      barrierDimisable: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * .06,
          ),
          child: Column(
            children: [
              TextFaildWidget(
                  controller: _firstNameController,
                  label: AppConfig.firstName,
                  obscure: false,
                  icon: const Icon(Icons.close),
                  inputType: TextInputType.text),
              SizedBox(height: size.height * .045),
              TextFaildWidget(
                  controller: _lastNameController,
                  label: AppConfig.lastName,
                  obscure: false,
                  icon: const Icon(Icons.close),
                  inputType: TextInputType.text),
              SizedBox(height: size.height * .045),
              TextFaildWidget(
                  controller: _emailController,
                  label: AppConfig.emal,
                  obscure: false,
                  icon: const Icon(Icons.close),
                  inputType: TextInputType.emailAddress),
              SizedBox(height: size.height * .045),
              TextFaildWidget(
                  controller: _phoneController,
                  label: AppConfig.phone,
                  obscure: false,
                  icon: const Icon(Icons.close),
                  inputType: TextInputType.number),
              SizedBox(height: size.height * .045),
              TextFaildWidget(
                  controller: _passwordController,
                  label: AppConfig.password,
                  icon: const Icon(Icons.remove_red_eye),
                  obscure: true,
                  inputType: TextInputType.text),
              SizedBox(height: size.height * .045),
              TextFaildWidget(
                  controller: _comfirmPasswordController,
                  label: AppConfig.comfirmPassword,
                  icon: const Icon(Icons.remove_red_eye),
                  obscure: true,
                  inputType: TextInputType.text),
              SizedBox(height: size.height * .025),
              const RadioButtonWidget(),
              SizedBox(height: size.height * .045),
              ButtonWidget(
                title: AppConfig.signUp,
                color: colorScheme.primary,
                onTap: () async {
                  _showDialog('');
                  UserAuth userAuth = UserAuth();
                  bool isSignup = await userAuth.userSignup(
                    context,
                    _emailController.text,
                    _firstNameController.text + _lastNameController.text,
                    _passwordController.text,
                    _phoneController.text,
                  );
                  myLog('isSignup', isSignup);
                  // _dialog.hide();

                  if (isSignup) {
                    //userSignup sucssufuly
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamed(AppConfig.login);
                  } else {
                    //userSignup faild try again later

                  }
                },
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      title: "  ${AppConfig.agreeTotermsOfServices}",
                      fontSize: 15,
                      color: colorScheme.onSecondary,
                    ),
                    TextWidget(
                      title: AppConfig.termsOfServices,
                      fontSize: 15,
                      color: colorScheme.primary,
                    ),
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
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.signUpWithEmail,
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
}
