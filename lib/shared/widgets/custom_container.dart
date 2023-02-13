import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.width,
    this.height,
    this.radius,
    this.verticalMargin,
    this.color,
    this.padding,
    this.margin,
    this.alignment,
    this.child,
    this.boxDecoration,
    this.borderWidth,
    this.borderColor,
    this.decorationImage,

    this.boxShadow,
  });
  final double? width, height, radius, verticalMargin, borderWidth;
  final Color? color, borderColor;
  final EdgeInsets? padding, margin;
  final AlignmentGeometry? alignment;
  final Widget? child;
  final Decoration? boxDecoration;
  final DecorationImage? decorationImage;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      width: width,
      margin: margin ?? EdgeInsets.symmetric(vertical: verticalMargin ?? 0),
      height: height,
      alignment: alignment,
      decoration: boxDecoration ??
          BoxDecoration(
            boxShadow: boxShadow,
            color: color ?? Colors.yellow,
            borderRadius: BorderRadius.circular(radius ?? 100),
            border: Border.all(
              strokeAlign: StrokeAlign.outside,
                width: borderWidth ?? 0,
                color: borderColor ?? Colors.transparent),
            image: decorationImage,
          ),
      child: child,
    );
  }
}
