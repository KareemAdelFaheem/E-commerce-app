import 'package:ecommerce/extensions/string_extensions.dart';
import 'package:flutter/material.dart';

Widget authTextField(String hint, TextInputType type, bool obsecure,TextEditingController controller) {
  return TextFormField(
    
    controller: controller,
    validator: (input) {
      if (input == null || input.isEmpty) {
        return obsecure?"Password can't be null":"email can't be null";
      }
      if (obsecure) {
        if (!input.isValidPassword()) {
          return "Password length must be at least 6 characters";
        }
      } else {
        if (!input.isValidEmail()) {
          return "Check you email";
        }
      }

      return null;
    },
    obscureText: obsecure,
    keyboardType: type,
    decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[800]),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10))),
  );
}
