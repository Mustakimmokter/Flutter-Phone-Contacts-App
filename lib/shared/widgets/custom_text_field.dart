import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
     this.controller,
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
    this.prefix,
    this.suffix,
    this.padding,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? hintText, obscuringCharacter;
  final Function(String)? onChanged, onSubmit;
  final bool? obscureText, autofocus;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? keyBoardType;
  final InputBorder? border;
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
      textCapitalization: TextCapitalization.words,
      autofocus: autofocus!,
      keyboardType: keyBoardType,
      onFieldSubmitted: onSubmit,
      obscuringCharacter: obscuringCharacter!,
      decoration: InputDecoration(
        contentPadding: padding ?? const EdgeInsets.only(top: 15),
        hintText: hintText,
        border: border ?? OutlineInputBorder(),
       prefixIcon: prefix,
        suffixIcon: suffix,
      ),
      inputFormatters: textInputFormatter,
    );
  }
}
