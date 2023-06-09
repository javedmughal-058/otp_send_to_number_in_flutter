import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isReadOnly;
  final Widget? suffixIcon;
  final TextInputType textInputType;
  final int? maxLines;
  final String? label;
  final String? hint;
  final double borderRadius;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final bool? isFilled;
  final Color borderColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? labelStyle;
  final AutovalidateMode? mode;

  const CustomTextField({Key? key,
    this.controller,
    required this.textInputType,
    required this.isReadOnly,
    this.suffixIcon,this.maxLines,
    this.label,this.hint,
    this.borderRadius = 5,
    this.fillColor,this.isFilled,
    this.onChanged,this.validator,this.borderColor = Colors.black26,
    this.contentPadding, this.labelStyle, this.mode }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null?
        Container():
        Text(label!,style: TextStyle(color: Theme.of(context).primaryColor)),
        TextFormField(
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          keyboardType: textInputType,
          readOnly: isReadOnly,
          maxLines: maxLines,
          autovalidateMode: mode,
          style: const TextStyle(color: Colors.black, fontSize: 13),
          decoration: InputDecoration(
            labelStyle: labelStyle,
            contentPadding: contentPadding,
            isDense: true,
            border: OutlineInputBorder(borderSide: BorderSide(color: borderColor),borderRadius: BorderRadius.circular(borderRadius)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),borderRadius: BorderRadius.circular(borderRadius)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: borderColor),borderRadius: BorderRadius.circular(borderRadius)),
            hintText: hint,
            focusColor: Theme.of(context).primaryColor,
            suffixIcon: suffixIcon,
            fillColor: fillColor,
            filled: isFilled,
          ),
        ),
      ],
    );
  }
}
