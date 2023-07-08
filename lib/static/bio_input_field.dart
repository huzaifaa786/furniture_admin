import 'package:flutter/material.dart';

class BioInputField extends StatelessWidget {
  const BioInputField(
      {Key? key,
      this.controller,
      this.hint,
      this.text,
      this.color = Colors.black,
      this.obscure = false,
      this.maxlines = false,
      this.enabled = true,
      this.readOnly = false,
      this.onChange,
      this.imageIcon,
      this.validator,
      this.autovalidateMode,
      // this.validate,
      this.icon,
      this.type = TextInputType.text,
      this.fontSize = 17.0,
      this.onpressed})
      : super(key: key);

  final controller;
  final validator;
  // final RxBool? validate;
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
    // bool isDark = Provider.of<DarkThemeProvider>(context).darkTheme;

    return TextFormField(
      
      readOnly: readOnly,
      enabled: enabled,
      controller: controller,
      style: TextStyle(fontSize: fontSize),
      obscureText: obscure,
      keyboardType: type,
      validator: validator,
      // autovalidateMode: autovalidateMode ??
      //     (validate == true.obs
      //         ? AutovalidateMode.always
      //         : AutovalidateMode.onUserInteraction),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey),
        fillColor: color,
        suffixIcon: IconButton(
          onPressed: onpressed,
          icon: imageIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ImageIcon(
                    AssetImage(imageIcon),
                    color: Colors.grey,
                  ),
                )
              : Icon(
                  icon,
                  color: Colors.grey,
                  size: 26,
                ),
        ),
        enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
      ),
      cursorColor: Colors.black,
      maxLines: maxlines == true ? null : 3,
    );
  }
}
