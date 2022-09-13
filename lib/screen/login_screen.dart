import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/shared_widgets/button_widget.dart';

import 'package:your_engineer/widget/shared_widgets/text_faild_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const SizedBox(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.04,
            vertical: size.height * .15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //const SizedBox(height: 250),
              TextFaildWidget(
                  controller: _emailController,
                  label: AppConfig.emal,
                  obscure: false,
                  icon: const Icon(Icons.close),
                  inputType: TextInputType.emailAddress),
              SizedBox(height: size.height * .055),
              TextFaildWidget(
                  controller: _passwordController,
                  label: AppConfig.password,
                  icon: const Icon(Icons.remove_red_eye),
                  obscure: true,
                  inputType: TextInputType.text),
              SizedBox(height: size.height * .1),
              ButtonWidget(
                  title: AppConfig.login,
                  color: colorScheme.primary,
                  onTap: () => null),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppConfig.forgetPassword),
                  child: TextWidget(
                      title: AppConfig.forgetPassword,
                      fontSize: 15,
                      color: colorScheme.primary),
                ),
              ),
              const SizedBox(height: 20),

              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppConfig.signUp),
                  child: TextWidget(
                      title: AppConfig.signUp,
                      fontSize: 15,
                      color: colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
