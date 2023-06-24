import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputFieldPassword extends StatelessWidget {
  const InputFieldPassword(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.icon,
      this.imageIcon,
      this.color = Colors.blue,
      this.obscure = false,
      this.toggle,
      this.onChange,
      this.validator,
      // this.validate,
      this.autovalidateMode,
      this.type = TextInputType.text,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  // final RxBool? validate;
  final autovalidateMode;
  final obscure;
  final hint;
  final type;
  final text;
  final icon;
  final imageIcon;
  final color;
  final toggle;
  final onChange;
  final onpressed;

  @override
  Widget build(BuildContext context) {
    // bool isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return TextFormField(
      style: const TextStyle(fontSize: 17),
      controller: controller,
      decoration: InputDecoration(
          fillColor: color,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 1.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: color, width: 1.7),
          ),
          suffixIcon: IconButton(
            padding: const EdgeInsets.only(bottom: 17),
            icon: Icon(
              // Based on passwordVisible state choose the icon
              obscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.white,
            ),
            onPressed: () {
              toggle();
            },
          ),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding: const EdgeInsets.only(left: 3.0)),
      keyboardType: type,
      cursorColor: Color.fromARGB(255, 0, 0, 0),
      obscureText: obscure,
      maxLines: 1,
      validator: validator,
      // autovalidateMode: autovalidateMode ??
      //     (validate == true.obs
      //         ? AutovalidateMode.always
      //         : AutovalidateMode.onUserInteraction),
    );
  }
}
