import 'package:flutter/material.dart';
import 'package:furniture_admin/static/bio_input_field.dart';
import 'package:furniture_admin/static/large_button.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:furniture_admin/values/colors.dart';

class EditCompanyScreen extends StatefulWidget {
  const EditCompanyScreen({super.key});

  @override
  State<EditCompanyScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Column(
            children: [
              TopBar(
                text: ' Add Company',
                ontap: () {},
              ),
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 104,
                    decoration: ShapeDecoration(
                      color: Color(0x11823E13),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF823E14)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/images/splash1.png')),
                  ),
                  Positioned(
                    left: 140,
                    top: 40,
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100)
                          //more than 50% of width makes circle
                          ),
                          child: Image.asset('assets/images/pen.png'),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Bio in english',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              BioInputField(),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Bio in arabic',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              BioInputField(),
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Working Hours',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                // width: 300,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: mainColor,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Image.asset('assets/images/clock.png'),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        children: [
                          Text(
                            'From',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('09:00'),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Row(
                        children: [
                          Text(
                            'To',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('05:00'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: LargeButton(title: 'Add', onPressed: () {}),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
