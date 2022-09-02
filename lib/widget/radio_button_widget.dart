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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Row(
            children: [
              Radio<int>(
                  value: 1,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              Text(
                AppConfig.engineer,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          Row(
            children: [
              Radio<int>(
                  value: 2,
                  groupValue: _value,
                  onChanged: (value) {
                    setState(() {
                      _value = value;
                    });
                  }),
              Text(
                AppConfig.projectOwner,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          )
        ]),
       
      ],
    );
  
    
  }
}
