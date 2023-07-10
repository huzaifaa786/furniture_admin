// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';

import 'messages_view.dart';

class ChatViewScreen extends StatefulWidget {
  const ChatViewScreen({super.key});

  @override
  State<ChatViewScreen> createState() => _ChatViewScreenState();
}

class _ChatViewScreenState extends State<ChatViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Column(children: [
                  TopBar(
                    ontap: () {
                      Get.back();
                    },
                    text: 'Chatting',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 97,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x21000000),
                                blurRadius: 28,
                                offset: Offset(2, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: ListTile(
                              leading: SizedBox(
                                height: 55,
                                width: 59,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    color: mainColor,
                                    child: SvgPicture.asset(
                                      'assets/images/profile.svg', // fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                'Dianne Russell',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                'Lorem ipsum dolor sit amet.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontFamily: 'Mazzard',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 30,
                              ),
                              onTap: () {
                           Get.to(() => MessageViewScreen());
                              },
                            ),
                          ),
                        ),
                    SizedBox(height:10.0,),
                     Container(
                          height: 97,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x21000000),
                                blurRadius: 28,
                                offset: Offset(2, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Center(
                            child: ListTile(
                              leading: SizedBox(
                                height: 55,
                                width: 59,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    color: mainColor,
                                    child: SvgPicture.asset(
                                      'assets/images/profile.svg', // fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                'Dianne Russell',
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600),
                              ),
                              subtitle: Text(
                                'Lorem ipsum dolor sit amet.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  fontFamily: 'Mazzard',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_circle_right_outlined,
                                size: 30,
                              ),
                              onTap: () {
                             Get.to(() => MessageViewScreen());
                              },
                            ),
                          ),
                        ),
                    
                      ],
                    ),
                  )
                ]))));
  }
}
