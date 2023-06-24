// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, deprecated_member_use, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_admin/values/colors.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({super.key, this.image, this.text, this.ontap});
  final image;
  final text;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.only(top: 12,bottom: 12),
        // height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: mainColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(45)),
                  child: FittedBox(
                    child: SvgPicture.asset(
                      image,
                      height: 16,
                    ),
                    fit: BoxFit.scaleDown,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:16.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            SvgPicture.asset(
              'assets/images/arrow_right.svg',
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
