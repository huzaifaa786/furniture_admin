// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:furniture_admin/values/colors.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key, this.ontap, this.text});
  final ontap;
  final text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: ontap,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  border: Border.all(color: Colors.grey)),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 21,
                fontWeight: FontWeight.w600),
          ),
          Text(
            '..........',
            style: TextStyle(color: white),
          )
        ],
      ),
    );
  }
}
