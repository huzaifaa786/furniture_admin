// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/models/bug_model.dart';
import 'package:furniture_admin/screen/bugs/bug_controller.dart';
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
        child: GetBuilder<BugController>(
          builder: (controller) => Padding(
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
                    height: MediaQuery.of(context).size.height * 0.85,
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: StreamBuilder<List<BugModel>>(
                      stream: bugController
                          .getItemsStream(), // Use the stream you created to fetch data
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          List<BugModel>? items = snapshot.data;

                          return ListView.builder(
                            itemCount: items!.length,
                            itemBuilder: (context, index) {
                              BugModel item = items[index];
                              return BugCard(
                                  id: item.id,
                                  description: item.description,
                                  image: item.image!,
                                  seen: item.seen,
                                 ontap: () {
                                    Get.to(() => BugDetail(
                                          bug: item,
                                        ));
                                  },
                                  );
                                  
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
