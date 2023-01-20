import 'package:flutter/material.dart';
import 'package:your_engineer/model/sub_catigory.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

class ListSubServicesWidget extends StatefulWidget {
  const ListSubServicesWidget({
    Key? key,
    required this.subServicesModel,
    required this.colorScheme,
    required this.size,
    required this.index,
    required this.expandeIndex,
  }) : super(key: key);
  final SubCatigoryModel subServicesModel;
  final ColorScheme colorScheme;
  final Size size;
  final int index;
  final int expandeIndex;

  @override
  State<ListSubServicesWidget> createState() => _ListSubServicesWidgetState();
}

class _ListSubServicesWidgetState extends State<ListSubServicesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: widget.expandeIndex == widget.index
              ? widget.colorScheme.primary
              : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextWidget(
              title: widget.subServicesModel.name!,
              fontSize: 17,
              color: widget.expandeIndex == widget.index
                  ? Colors.white
                  : widget.colorScheme.background,
            ),
          ),
        ),
      ],
    );
  }
}
