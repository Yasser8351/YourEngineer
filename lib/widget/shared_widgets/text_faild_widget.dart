import 'package:flutter/material.dart';

class TextFaildWidget extends StatelessWidget {
  const TextFaildWidget({
    Key? key,
    required this.controller,
    required this.label,
    required this.obscure,
    required this.inputType,
    required this.icon,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final bool obscure;
  final TextInputType inputType;
  final IconButton icon;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Theme.of(context).colorScheme.onSecondary,
        primaryColorDark: Theme.of(context).colorScheme.onSecondary,
        focusColor: Theme.of(context).colorScheme.primary,
        colorScheme: ColorScheme(
          primary: Theme.of(context).colorScheme.primary,
          onPrimary: Colors.black,
          secondary: Colors.black,
          onSecondary: Colors.white,
          brightness: Brightness.light,
          background: Colors.black,
          onBackground: Colors.black,
          error: Colors.black,
          onError: Colors.black,
          surface: Colors.black,
          onSurface: Colors.black,
        ),
      ),
      child: Material(
        elevation: 1,
        shadowColor: Colors.white30,
        //color: Colors.white,
        // child: Directionality(
        //  // textDirection: TextDirection.rtl,
        child: TextField(
          keyboardType: inputType,
          obscureText: obscure,
          //textAlign: TextAlign.right,
          decoration: InputDecoration(
              suffixIcon: controller.text.isEmpty ? const SizedBox() : icon,
              labelText: label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
              )),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 17,
          ),
          controller: controller,
        ),
      ),
    );
  }
}
