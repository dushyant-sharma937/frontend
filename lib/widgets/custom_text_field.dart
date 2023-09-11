import 'package:flutter/material.dart';
import 'package:frontend/consts/colors.dart';

Widget customTextField({
  label,
  hintText,
  controller,
  isDesc = false,
  autofocus = false,
  borderColor = Colors.black,
  color = Colors.white,
  ti = TextInputType.text,
  onSubmitted,
}) {
  return TextFormField(
    autofocus: autofocus,
    controller: controller,
    obscureText: false,
    maxLines: isDesc ? 4 : 1,
    keyboardType: ti,
    style: TextStyle(
      color: color,
    ),
    decoration: InputDecoration(
      isDense: true,
      label: Text(label),
      labelStyle: TextStyle(color: color),
      hintText: hintText,
      hintStyle: const TextStyle(color: fontGrey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: color,
        ),
      ),
    ),
  );
}

Widget customPasswordTextField(
    {label,
    hintText,
    controller,
    borderColor = Colors.white,
    isPass,
    icon,
    onPress,
    color = Colors.black87}) {
  return TextFormField(
    controller: controller,
    obscureText: isPass,
    style: TextStyle(
      color: color,
    ),
    decoration: InputDecoration(
      suffixIcon: IconButton(
        icon: Icon(
          !isPass ? Icons.visibility : Icons.visibility_off,
          color: Colors.white,
        ),
        onPressed: onPress,
      ),
      isDense: true,
      label: Text(label),
      labelStyle: TextStyle(color: color),
      hintText: hintText,
      hintStyle: const TextStyle(color: fontGrey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: borderColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: color,
        ),
      ),
    ),
  );
}
