// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  const InputField(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.color = Colors.white,
      this.obscure = false,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.onChange,
      this.imageIcon,
      this.validator,
      this.validate,
      this.autovalidateMode,
      this.icon,
      this.type = TextInputType.text,
      this.fontSize = 17.0,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  final validate;
  final obscure;
  final hint;
  final type;
  final imageIcon;
  final icon;
  final text;
  final autovalidateMode;
  final color;
  final maxlines;
  final onChange;
  final onpressed;
  final fontSize;
  final enabled;
  final readOnly;
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: TextFormField(
                  readOnly: readOnly,
                  enabled: enabled,
                  controller: controller,
                  style: TextStyle(fontSize: fontSize),
                  obscureText: obscure,
                  autovalidateMode: autovalidateMode ??
                      (validate == true.obs
                          ? AutovalidateMode.always
                          : AutovalidateMode.onUserInteraction),
                  keyboardType: type,
                  validator: validator,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 4),
                    hintText: hint,
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w400),
                    fillColor: color,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  cursorColor: Colors.black,
                  maxLines: maxlines == true ? null : 1,
                )
    );
  }
}
