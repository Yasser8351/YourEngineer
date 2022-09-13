import 'package:flutter/material.dart';
import 'package:your_engineer/model/notifcation_model.dart';

import '../app_config/app_config.dart';
import '../widget/notifcation_widget.dart';
import '../widget/shared_widgets/text_widget.dart';

class NotifcationScreen extends StatefulWidget {
  const NotifcationScreen({Key? key}) : super(key: key);

  @override
  State<NotifcationScreen> createState() => _NotifcationScreenState();
}

class _NotifcationScreenState extends State<NotifcationScreen> {
  List<NotifcationModel> notifcationList = [
    NotifcationModel(
        title: "Get 20% off your first order! use promo code : fires_order",
        notifcationDate: "2 days ago"),
    NotifcationModel(
        title: "Congratulations, the project has been completed successfully",
        notifcationDate: "4 days ago"),
    NotifcationModel(
        title: "\$200 + has been deposited in your account",
        notifcationDate: "7 days ago"),
    NotifcationModel(
        title: "Get 20% off your first order! use promo code : fires_order",
        notifcationDate: "2 days ago"),
    NotifcationModel(
        title: "Congratulations, the project has been completed successfully",
        notifcationDate: "4 days ago"),
    NotifcationModel(
        title: "\$200 + has been deposited in your account",
        notifcationDate: "7 days ago"),
    NotifcationModel(
        title: "Get 20% off your first order! use promo code : fires_order",
        notifcationDate: "2 days ago"),
    NotifcationModel(
        title: "Congratulations, the project has been completed successfully",
        notifcationDate: "4 days ago"),
    NotifcationModel(
        title: "\$200 + has been deposited in your account",
        notifcationDate: "7 days ago"),
  ];
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _getAppBar(context),
      body: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(),
        itemCount: notifcationList.length,
        itemBuilder: (context, index) {
          return NoticationWidget(
            colorScheme: colorScheme,
            size: size,
            notifcationModel: notifcationList[index],
          );
        },
      ),
    );
  }

  _getAppBar(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 10),
        child: TextWidget(
            title: AppConfig.notifcation, fontSize: 18, color: Colors.white),
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
