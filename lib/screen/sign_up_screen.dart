import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/button_widget.dart';

import 'package:your_engineer/widget/text_faild_widget.dart';
import 'package:your_engineer/widget/text_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _comfirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: _getAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * .08,
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
              SizedBox(height: size.height * .045),
              ButtonWidget(
                title: AppConfig.signUp,
                color: colorScheme.primary,
                onTap: () =>
                    Navigator.of(context).pushNamed(AppConfig.tabScreen),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      title: AppConfig.agreeTotermsOfServices,
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

  _getAppBar() {
    return AppBar(
      title: const TextWidget(
          title: AppConfig.signUpWithEmail, fontSize: 18, color: Colors.white),
      leading: const Icon(Icons.navigate_before),
    );
  }
}
