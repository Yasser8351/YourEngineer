import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:your_engineer/app_config/app_config.dart';
import 'package:your_engineer/widget/shared_widgets/button_widget.dart';

import 'package:your_engineer/widget/shared_widgets/text_faild_widget.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../api/user_auth.dart';
import '../utilits/helper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool isLoading = false;
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
                  label: AppConfig.emal.tr,
                  obscure: false,
                  icon: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.close),
                  ),
                  inputType: TextInputType.emailAddress),
              SizedBox(height: size.height * .09),

              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ButtonWidget(
                      title: AppConfig.send.tr,
                      color: colorScheme.primary,
                      onTap: () async {
                        if (_emailController.text.isEmpty) {
                          Helper.showError(
                              context: context,
                              subtitle: AppConfig.allFaildRequired.tr);
                          return;
                        }

                        setState(() => isLoading = true);
                        UserAuth userAuth = UserAuth();
                        bool isSignup = await userAuth.resetPassword(
                          context,
                          _emailController.text,
                        );
                        setState(() => isLoading = false);
                      }),
            ],
          ),
        ),
      ),
    );
  }

  _getAppBar() {
    return AppBar(
      title: TextWidget(
          title: AppConfig.resetPassword.tr, fontSize: 25, color: Colors.white),
      leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.navigate_before, color: Colors.white, size: 40)),
    );
  }
}
