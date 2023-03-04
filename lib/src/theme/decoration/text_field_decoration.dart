import 'package:flutter/material.dart';

import '../colors.dart';
import '../font_style.dart';

class TextFormDecoration {
  static decoration({
    required String hintText,
    String? labelText,
    IconData? prefixIcon,
    IconData? suffixIcon,
    Widget? suffix,
    Widget? prefix,
    String? errorText,
  }) {
    return InputDecoration(
      prefixIcon:
          (prefixIcon == null) ? null : Icon(prefixIcon, color: primaryColor),
      suffixIcon:
          (suffixIcon == null) ? null : Icon(suffixIcon, color: primaryColor),
      suffix: suffix,
      prefix: prefix,
      errorText: errorText,
      fillColor: textFormFieldColor,
      filled: true,
      counter: const Offstage(),
      isDense: true,
      hintText: hintText,
      labelText: labelText,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      hintStyle: kHintTextStyle,
      contentPadding: const EdgeInsets.all(10.0),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: primaryColor)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: BorderSide(color: borderColor),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }
}
