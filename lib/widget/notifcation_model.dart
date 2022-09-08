import 'package:flutter/material.dart';

import '../model/notifcation_model.dart';

class NoticationWidget extends StatelessWidget {
  const NoticationWidget({
    Key? key,
    required this.colorScheme,
    required this.size,
    required this.notifcationModel,
  }) : super(key: key);

  final ColorScheme colorScheme;
  final Size size;
  final NotifcationModel notifcationModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: colorScheme.surface,
            radius: 26.0,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none,
                size: 30,
              ),
              color: colorScheme.secondary,
            ),
          ),
          SizedBox(width: size.width * .04),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  width: size.width / 1.5, child: Text(notifcationModel.title)),
              SizedBox(
                  width: size.width / 1.5,
                  child: Text(notifcationModel.notifcationDate)),
            ],
          ),
        ],
      ),
    );
  }
}
