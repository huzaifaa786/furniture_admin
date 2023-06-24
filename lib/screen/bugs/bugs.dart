// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:furniture_admin/screen/bugs/bugs_detail.dart';
import 'package:furniture_admin/static/bug_card.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:get/get.dart';

class BugsScreen extends StatefulWidget {
  const BugsScreen({super.key});

  @override
  State<BugsScreen> createState() => _BugsScreenState();
}

class _BugsScreenState extends State<BugsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              TopBar(
                ontap: () {
                  Get.back();
                },
                text: 'Bugs',
              ),
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  padding: EdgeInsets.only(top: 6),
                  child: ListView.builder(
                      itemCount: 15,
                      itemBuilder: (BuildContext context, int index) {
                        return BugCard(
                          ontap: () {
                            Get.to(() => BugDetail());
                          },
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
