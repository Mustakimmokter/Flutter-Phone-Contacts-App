import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontFamily,
    this.lineSpacing,
    this.wordSpacing,
    this.letterSpacing,
    this.textAlign,
    this.textDecoration,
    this.maxLine,
    this.textColor,
    this.fontHeight,
    this.textOverflow,
    this.fontStyle,
    this.textBaseline,
    this.textDecorationStyle,
    this.fontWeight,
    this.textAlignVertical,
  });
  final String text;
  final String? fontFamily;
  final double? fontSize, fontHeight, lineSpacing, wordSpacing, letterSpacing;
  final TextAlign? textAlign;
  final TextDecoration? textDecoration;
  final int? maxLine;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextOverflow? textOverflow;
  final FontStyle? fontStyle;
  final TextBaseline? textBaseline;
  final TextDecorationStyle? textDecorationStyle;
  final TextAlignVertical? textAlignVertical;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLine,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        height: fontHeight,
        color: textColor,
        fontWeight: fontWeight,
        overflow: TextOverflow.ellipsis,
        fontFamily: fontFamily,
        fontStyle: fontStyle,
        wordSpacing: wordSpacing,
        letterSpacing: letterSpacing,
        textBaseline: textBaseline,
        decoration: textDecoration,
        decorationStyle: textDecorationStyle,
      ),
    );
  }
}
