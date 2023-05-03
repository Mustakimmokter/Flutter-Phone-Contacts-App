import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/widgets/custom_text.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    this.onPressed,
    this.onLongPress,
    this.text,
    this.child,
    this.height,
    this.elevation,
    this.minWidth,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.padding,
    this.horizontalPadding,
    this.verticalPadding,
    this.textColor,
    this.width,
  });

  final VoidCallback? onPressed, onLongPress;
  final String? text;
  final Widget? child;
  final double? height,
      elevation,
      width,
      minWidth,
      borderRadius,
      borderWidth,
      horizontalPadding,
      verticalPadding;
  final Color? borderColor, backgroundColor, textColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 0,
              vertical: verticalPadding ?? 0),
      child: SizedBox(
        width: width ?? double.maxFinite,
        height: height ?? 40,
        child: RawMaterialButton(
          elevation: 0,
          onPressed: onPressed,
          fillColor: backgroundColor ?? Colors.red,
          onLongPress: onLongPress,
          focusColor: Colors.deepOrangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 05),
            side: BorderSide(
              color: borderColor ?? Colors.transparent,
              width: borderWidth ?? 0,
            ),
          ),
          child: child ??
              CustomText(
                text: text ?? 'null',
                textColor: textColor ?? Colors.white,
              ),
        ),
      ),
    );
  }
}
