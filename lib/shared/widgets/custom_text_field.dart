import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.onChanged,
    this.obscuringCharacter = '*',
    this.obscureText = false,
    this.validator,
    this.textInputFormatter,
    this.keyBoardType,
    this.onSubmit,
    this.border,
    this.autofocus = false,
    this.onTap,
    this.prefix,
    this.suffix,
    this.padding,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText, obscuringCharacter;
  final Function(String)? onChanged, onSubmit;
  final bool? obscureText, autofocus;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? keyBoardType;
  final InputBorder? border;
  final VoidCallback? onTap;
  final Widget? prefix,suffix;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText!,
      autofocus: autofocus!,
      keyboardType: keyBoardType,
      onFieldSubmitted: onSubmit,
      onTap: onTap,
      obscuringCharacter: obscuringCharacter!,
      decoration: InputDecoration(
        contentPadding: padding ?? const EdgeInsets.only(top: 15),
        hintText: hintText,
        border: border,
       prefixIcon: prefix,
        suffixIcon: suffix,
      ),
      inputFormatters: textInputFormatter,
    );
  }
}
