// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:get/get.dart';

class BugDetail extends StatefulWidget {
  const BugDetail({super.key});

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
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/bugimg.png'),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Text(
                          'Lorem ipsum dolor sit amet consectetur. Eget urna aliquet mauris nulla elementum. Consectetur mattis in eget ultrices sed luctus amet. Id vitae fames tellus fermentum diam ultrices non cras eget. Arcu tortor quis mauris a fermentum vitae purus. Odio.\n Lorem ipsum dolor sit amet consectetur. Eget urna aliquet mauris nulla elementum. Consectetur mattis in eget ultrices sed luctus amet. Id vitae fames tellus fermentum diam ultrices non cras eget. Arcu tortor quis mauris a fermentum vitae purus. Odio.Lorem ipsum dolor sit amet consectetur. Eget urna aliquet mauris nulla elementum. Consectetur mattis in eget ultrices sed luctus amet. Id vitae fames tellus fermentum diam ultrices non cras eget. Arcu tortor quis mauris a fermentum vitae purus. Odio.Lorem ipsum dolor sit amet consectetur. Eget urna aliquet mauris nulla elementum. Consectetur mattis in eget ultrices sed luctus amet. Id vitae fames tellus fermentum diam ultrices non cras eget. Arcu tortor quis mauris a fermentum vitae purus. Odio.Lorem ipsum dolor sit amet consectetur. Eget urna aliquet mauris nulla elementum. Consectetur mattis in eget ultrices sed luctus amet. Id vitae fames tellus fermentum diam ultrices non cras eget. Arcu tortor quis mauris a fermentum vitae purus. Odio.Lorem ipsum dolor sit amet consectetur. Eget urna aliquet mauris nulla elementum. Consectetur mattis in eget ultrices sed luctus amet. Id vitae fames tellus fermentum diam ultrices non cras eget. Arcu tortor quis mauris a fermentum vitae purus. Odio.Lorem ipsum dolor sit amet consectetur. Eget urna aliquet mauris nulla elementum. Consectetur mattis in eget ultrices sed luctus amet. Id vitae fames tellus fermentum diam ultrices non cras eget. Arcu tortor quis mauris a fermentum vitae purus. Odio.Lorem ipsum dolor sit amet consectetur. Eget urna aliquet mauris nulla elementum. Consectetur mattis in eget ultrices sed luctus amet. Id vitae fames tellus fermentum diam ultrices non cras eget. Arcu tortor quis mauris a fermentum vitae purus. Odio.Lorem ipsum dolor sit amet consectetur. Eget urna aliquet mauris nulla elementum. Consectetur mattis in eget ultrices sed luctus amet. Id vitae fames tellus fermentum diam ultrices non cras eget. Arcu tortor quis mauris a fermentum vitae purus. Odio.',
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
