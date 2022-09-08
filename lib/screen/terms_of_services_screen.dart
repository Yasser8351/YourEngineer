import 'package:flutter/material.dart';

import '../app_config/app_config.dart';
import '../widget/animated_text_wIth_card.dart';
import '../widget/text_widget.dart';

//PrivacyPolicyScreen
class TermsOfServicesScreen extends StatefulWidget {
  const TermsOfServicesScreen({Key? key}) : super(key: key);

  @override
  State<TermsOfServicesScreen> createState() => _TermsOfServicesScreenState();
}

class _TermsOfServicesScreenState extends State<TermsOfServicesScreen> {
  var _expand1 = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            children: [
              AnimatedTextWIthCard(
                title: AppConfig.termsOfServices,
                discreption: AppConfig.text1,
                expand: _expand1,
                onTap: () {
                  setState(() {
                    _expand1 = !_expand1;
                  });
                },
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
            title: AppConfig.termsOfServices,
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
}
