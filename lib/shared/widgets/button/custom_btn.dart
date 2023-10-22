import 'package:flutter/material.dart';
import 'package:phone_contact_app/shared/utils/index.dart';

class CustomBtn extends StatelessWidget {
  const CustomBtn({
    super.key,
    this.onPressed,
    this.text,
    this.child,
    this.height,
    this.elevation,
    this.borderRadius,
    this.borderWidth,
    this.borderColor,
    this.backgroundColor,
    this.width,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final double? height, width, elevation, borderRadius, borderWidth;
  final Color? borderColor, backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height ?? 50,
      child: RawMaterialButton(
        elevation: elevation ?? 0,
        onPressed: onPressed,
        fillColor: backgroundColor ?? brandSecondaryColor,
        focusColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 05),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 0,
          ),
        ),
        child: child ?? Text(
          text ?? 'null',
          style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16,),
            ),
      ),
    );
  }
}
