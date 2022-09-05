import 'package:flutter/material.dart';

import '../app_config/app_config.dart';

class RadioButtonWidget extends StatefulWidget {
  const RadioButtonWidget({Key? key}) : super(key: key);

  @override
  State<RadioButtonWidget> createState() => _RadioButtonWidgetState();
}

class _RadioButtonWidgetState extends State<RadioButtonWidget> {
  int? _value = 2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(children: [
          Row(
            children: [
              Radio<int>(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  AppConfig.engineer,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Radio<int>(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  AppConfig.projectOwner,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          )
        ]),
      ],
    );
  }
}
