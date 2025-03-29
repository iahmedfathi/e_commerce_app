import 'package:flutter/material.dart';
import 'package:shop_app/core/utils/app_colors.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required this.hintText,
    this.omnChange,
    this.obscureText = false,
    this.onSaved,
    this.controller,
    this.enabledBorder,
    this.focusedBorder,
    this.validator,
    this.keyboardType,
    this.border,
    this.labelText,
    this.fillColor,
    this.filled,
    this.hintMaxLines,
    this.prefix,
    this.suffix,
    this.labelStyle,
    this.hintStyle,
    this.cursorColor,
    this.style,
    this.minLines,
    this.maxLines,
    this.word,
    this.prefixIcon,
    this.textAlign,
    this.contentPadding,
  });
  final String? word;
  final String hintText;
  final Function(String)? omnChange;
  final bool? obscureText;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final String? labelText;
  final Color? fillColor;
  final bool? filled;
  final int? hintMaxLines;
  final Widget? prefix;
  final Widget? suffix;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final Color? cursorColor;
  final TextStyle? style;
  final int? minLines;
  final int? maxLines;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlign: textAlign ?? TextAlign.center,
      obscureText: false,
      autofocus: true,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 5,
      style: style ?? TextStyle(color: Colors.grey),
      cursorColor: cursorColor ?? Color(0xff037EE6),
      controller: controller,
      validator: validator ??
          (data) {
            if (data!.isEmpty) {
              return 'felid is required';
            }
            return null;
          },
      onSaved: onSaved,
      keyboardType: keyboardType ?? TextInputType.emailAddress,
      onChanged: omnChange,
      decoration: InputDecoration(
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          prefixIcon: prefixIcon,
          filled: filled,
          hintStyle: hintStyle ?? TextStyle(color: Colors.grey),
          labelStyle: labelStyle,
          fillColor: fillColor,
          border: border ?? const OutlineInputBorder(),
          hintText: hintText,
          prefix: prefix,
          suffix: suffix,
          hintMaxLines: hintMaxLines,
          labelText: labelText,
          focusedBorder: focusedBorder ?? buildBorder(),
          enabledBorder: enabledBorder ?? buildBorder(),
          errorBorder: buildBorder(color: Colors.red),
          focusedErrorBorder: buildBorder(color: Colors.red)),
    );
  }

  OutlineInputBorder buildBorder({Color? color, BorderRadius? borderRadius}) {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? AppColors.mainColor,
          width: 2,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(50));
  }
}
