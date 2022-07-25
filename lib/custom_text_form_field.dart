import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class custom_text_form_field extends StatelessWidget {

  var validator;
  var controller;
  var keyboardType;
  var onSaved;
  Icon? suffixIcon;
  Icon? prefixIcon;
  bool? enableed;
  String? hint;
  bool? phone = false;
  custom_text_form_field(
      {this.validator,
        this.enableed,
      this.suffixIcon,
      this.controller,
      this.prefixIcon,
      this.keyboardType,
      this.onSaved,
      this.hint,
      this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (phone == true)
          ? EdgeInsetsDirectional.only(top: 15)
          : EdgeInsetsDirectional.only(top: 15, bottom: 10),
      child: TextFormField(

        maxLength: (phone == true) ? 11 : null,
        validator: validator,
        keyboardType: keyboardType,
        onSaved: onSaved,

        controller: controller,
        decoration: InputDecoration(
          enabled: enableed==null?true:enableed!,
          fillColor: Colors.grey.shade400,
          hintText: hint,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: const TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.all(10),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.grey, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey, width: 1),
          ),
        ),
      ),
    );
  }
}
