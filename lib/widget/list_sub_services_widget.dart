import 'package:flutter/material.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

import '../model/sub_services_model.dart';

class ListSubServicesWidget extends StatelessWidget {
  const ListSubServicesWidget({
    Key? key,
    required this.subServicesModel,
    required this.colorScheme,
    required this.size,
    required this.index,
    required this.expandeIndex,
  }) : super(key: key);
  final SubServicesModel subServicesModel;
  final ColorScheme colorScheme;
  final Size size;
  final int index;
  final int expandeIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            color:
                expandeIndex == index ? colorScheme.background : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextWidget(
                title: subServicesModel.title,
                fontSize: 17,
                color: expandeIndex == index
                    ? Colors.white
                    : colorScheme.background,
              ),
            ),
          ),
          const Text("data")
        ],
      ),
    );
  }
}
