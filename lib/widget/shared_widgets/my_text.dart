import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final _TextStyles _textStyle;
  final int? maxLines;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDirection? textDirection;
  const MyText.h1(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.fontSize,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.headline1,
        super(key: key);
  const MyText.h2(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.fontSize,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.headline2,
        super(key: key);
  const MyText.h3(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.softWrap,
      this.fontSize,
      this.overflow,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.headline3,
        super(key: key);
  const MyText.h4(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.softWrap,
      this.fontSize,
      this.overflow,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.headline4,
        super(key: key);
  const MyText.h5(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.fontSize,
      this.softWrap,
      this.overflow,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.headline5,
        super(key: key);
  const MyText.h6(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.softWrap,
      this.fontSize = 16,
      this.overflow,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.headline6,
        super(key: key);
  const MyText.subtitle(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.fontSize,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.subtitle1,
        super(key: key);
  const MyText.subtitle2(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.fontSize,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.subtitle2,
        super(key: key);
  const MyText.body(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.fontSize,
      this.softWrap,
      this.overflow,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.body1,
        super(key: key);
  const MyText.body2(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.fontSize,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.body2,
        super(key: key);
  const MyText.button(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.fontSize,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.button,
        super(key: key);
  const MyText.overline(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.maxLines,
      this.fontSize,
      this.softWrap,
      this.overflow,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.overline,
        super(key: key);
  const MyText.caption(this.text,
      {Key? key,
      this.color,
      this.textAlign,
      this.fontSize,
      this.maxLines,
      this.softWrap,
      this.overflow,
      this.fontWeight,
      this.textDirection})
      : _textStyle = _TextStyles.caption,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: _getTextTheme(context),
      maxLines: maxLines ?? 1,
      softWrap: softWrap,
      overflow: overflow,
      textDirection: textDirection,
      textAlign: textAlign,
    );
  }

  TextStyle? _getTextTheme(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (_textStyle) {
      case _TextStyles.headline1:
        return Theme.of(context).textTheme.displayLarge?.copyWith(
              color: color,
              fontWeight: fontWeight,
            );
      case _TextStyles.headline2:
        return textTheme.displayMedium?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.headline3:
        return textTheme.displaySmall?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.headline4:
        return textTheme.headlineMedium?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.headline5:
        return textTheme.headlineSmall?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.headline6:
        return textTheme.titleLarge?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.subtitle1:
        return textTheme.titleMedium?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.subtitle2:
        return textTheme.titleSmall?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.body1:
        return textTheme.bodyLarge?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.body2:
        return textTheme.bodyMedium?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.button:
        return textTheme.labelLarge?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.overline:
        return textTheme.labelSmall?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
      case _TextStyles.caption:
        return textTheme.bodySmall?.copyWith(
            color: color, fontWeight: fontWeight, fontSize: fontSize);
    }
  }
}

enum _TextStyles {
  headline1,
  headline2,
  headline3,
  headline4,
  headline5,
  headline6,
  subtitle1,
  subtitle2,
  body1,
  body2,
  button,
  overline,
  caption,
}
