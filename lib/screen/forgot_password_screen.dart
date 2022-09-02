import 'package:flutter/material.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/button_widget.dart';

import 'package:your_engineer/widget/text_faild_widget.dart';
import 'package:your_engineer/widget/text_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
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
            vertical: size.height * .09,
          ),
          child: Column(
            children: [
              //const SizedBox(height: 250),
              TextFaildWidget(
                  controller: _emailController,
                  label: AppConfig.emal,
                  obscure: false,
                  icon: const Icon(Icons.close),
                  inputType: TextInputType.emailAddress),
              SizedBox(height: size.height * .09),

              ButtonWidget(
                  title: AppConfig.send,
                  color: colorScheme.primary,
                  onTap: () => null),
              Align(
                alignment: Alignment.centerRight,
                child: TextWidget(
                    title: AppConfig.forgetPassword,
                    fontSize: 15,
                    color: colorScheme.primary),
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
          title: AppConfig.forgetPassword, fontSize: 25, color: Colors.white),
      leading: const Icon(Icons.navigate_before),
    );
  }
}
