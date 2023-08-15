// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:furniture_admin/models/bug_model.dart';
import 'package:furniture_admin/screen/chat/full_photo_page.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:get/get.dart';

class BugDetail extends StatefulWidget {
  const BugDetail({super.key,this.bug});
  final BugModel? bug;
  @override
  State<BugDetail> createState() => _BugDetailState();
}

class _BugDetailState extends State<BugDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            TopBar(
              text: 'Bug Detail',
              ontap: () {
                Get.back();
              },
            ),
            Flexible(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.95,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {
                            Get.to(()=> FullPhotoPage(url: widget.bug!.image!));
                          },
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(widget.bug!.image!),
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          widget.bug!.description!,
                          textAlign: TextAlign.justify,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
