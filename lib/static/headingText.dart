import 'package:flutter/material.dart';

class HeadingText extends StatelessWidget {
  const HeadingText({super.key,this.text});
  final text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 20),
    );
  }
}
