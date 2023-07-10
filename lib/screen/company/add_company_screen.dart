import 'package:flutter/material.dart';
import 'package:furniture_admin/static/bio_input_field.dart';
import 'package:furniture_admin/static/topbar.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Column(
            children: [
              TopBar(
                text: ' Add Company',
                ontap: () {},
              ),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Image(
                          image: AssetImage('assets/images/addcompanyy.png')),
                    ),
                    Text(
                      'Upload Photo',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
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
             
          ],
          ),
        ),
      )),
    );
  }
}
