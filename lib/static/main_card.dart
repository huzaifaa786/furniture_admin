// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:badges/badges.dart' as badges;

class MainCard extends StatelessWidget {
  const MainCard({
    super.key,
    this.title,
    this.image,
    this.ontap,
    this.badgeValue = '0',
  });
  final title;
  final image;
  final ontap;
  final badgeValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: mainColor,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: white,
                ),
                child: badges.Badge(
                  showBadge: badgeValue == '0'? false: true,
                  badgeContent: Text(badgeValue,style: TextStyle(color: white),),
                  child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: SvgPicture.asset(image, height: 30, width: 30)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 14, color: white),
                ),
              )
            ],
          )),
    );
  }
}
