import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:your_engineer/widget/shared_widgets/text_widget.dart';

class TextFaildInput extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onTap;
  final VoidCallback? onSubmit;
  final String? hint;
  final String? label;
  final Color? labelColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextDirection? textDirection;
  final bool password;
  final int? maxLength;
  final int? maxLines;
  final InputBorder _outlinedBorder;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String? leadingText;
  final String? trailingText;
  final FormFieldValidator? validationMessages;
  final double padingAll;
  final double labelPaddingStart;
  final double labelPaddingTop;
  final double labelPaddingBottom;
  final double labelPaddingEnd;
  final bool enableInteractiveSelection;

  const TextFaildInput(
      {Key? key,
      required this.controller,
      this.validationMessages,
      this.hint,
      this.label,
      this.labelColor,
      this.onTap,
      this.inputFormatters,
      this.password = false,
      this.padingAll = 0.0,
      this.onSubmit,
      this.inputType,
      this.inputAction = TextInputAction.done,
      this.textDirection,
      this.leadingIcon,
      this.trailingIcon,
      this.leadingText,
      this.trailingText,
      this.maxLength,
      this.maxLines,
      this.labelPaddingStart = 0.0,
      this.labelPaddingTop = 0.0,
      this.labelPaddingBottom = 0.0,
      this.labelPaddingEnd = 0.0,
      this.enableInteractiveSelection = true})
      : _outlinedBorder = const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.0))),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null)
          Padding(
              padding: EdgeInsetsDirectional.only(
                  start: labelPaddingStart,
                  end: labelPaddingEnd,
                  bottom: labelPaddingBottom,
                  top: labelPaddingTop),
              child: TextWidget(
                title: label ?? 'No Label',
                fontSize: 17,
                color: Colors.black,
              )
              // child: MyText.body( labelPaddingTop labelPaddingTop labelPaddingBottom labelPaddingEnd  labelPaddingStart
              //   label ?? 'No Label',
              //   color: Colors.black,
              // ),
              ),
        if (label != null)
          SizedBox(
            height: 10,
          ),
        Padding(
          padding: EdgeInsets.all(padingAll),
          child: TextFormField(
            controller: controller,
            autocorrect: false,
            // onTap: onTap,
            onChanged: (value) => log(value),
            // cursorColor: kcPrimary,
            cursorRadius: const Radius.circular(2.0),
            inputFormatters: inputFormatters,
            obscureText: password,
            // onEditingComplete: onSubmit,
            onFieldSubmitted: null,
            keyboardType: inputType,
            textInputAction: inputAction,
            maxLength: maxLength,
            maxLines: maxLines ?? 1,
            style: Theme.of(context).textTheme.bodySmall,
            // .bodyText1,
            textDirection: textDirection,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            validator: validationMessages,
            // selectionControls: CupertinoTextSelectionControls(),
            enableInteractiveSelection: enableInteractiveSelection == false
                ? enableInteractiveSelection
                : !password,
            // textAlign: ,
            decoration: InputDecoration(
              helperStyle: Theme.of(context).textTheme.bodySmall,
              // .overline,
              prefixIcon: leadingIcon,
              prefixText: leadingText,
              suffixIcon: trailingIcon,
              suffixText: leadingText,
              // bloc.state.locale.languageCode == 'ar' ? leadingText : null,
              hintText: hint,
              hintMaxLines: 1,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodySmall
                  // .bodyText2
                  ?.copyWith(color: Colors.grey[350]),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              filled: true,
              // fillColor: kcGreyVeryLight,
              border: _outlinedBorder.copyWith(
                borderSide: BorderSide(width: 1.0, color: Colors.grey[300]!),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              errorBorder: _outlinedBorder.copyWith(
                borderSide: const BorderSide(color: Colors.red, width: 1.0),
              ),
              enabledBorder: _outlinedBorder.copyWith(
                borderSide: BorderSide(width: 1.0, color: Colors.grey[300]!),
              ),
              focusedBorder: _outlinedBorder.copyWith(
                  // borderSide: const BorderSide(color: kcAccentDark),
                  ),
              counterStyle: Theme.of(context).textTheme.bodySmall,
              //  counterStyle: Theme.of(context).textTheme.caption,

              errorStyle: Theme.of(context)
                  .textTheme
                  .bodySmall
                  // .caption
                  ?.copyWith(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
/*
 FcbInput(
              formControllerName: loginForm.accountContName,
              label: localizations.accountOrPhone,
              hint: localizations.accountOrPhoneHint,
              maxLength: 11,
              validationMessages: accountValidationMessages,
              textDirection: TextDirection.ltr,
            ),
*/