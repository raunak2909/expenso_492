import 'package:flutter/material.dart';

InputDecoration mFieldDecor({
  required String hint,
  required String label,
  bool isPassField = false,
  bool isPassVisible = false,
  void Function()? callBack,
}) {
  return InputDecoration(
    fillColor: Colors.white,
    filled: true,
    suffixIcon: isPassField ? IconButton(
      onPressed: callBack,
      icon: Icon(isPassVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined),
    ) : null,
    hintText: hint,
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(21),
      borderSide: BorderSide(color: Colors.pink.shade200, width: 2),
    ),
    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
  );
}
