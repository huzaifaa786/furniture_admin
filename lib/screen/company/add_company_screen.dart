import 'dart:io';

import 'package:flutter/material.dart';
import 'package:furniture_admin/helper/general.dart';
import 'package:furniture_admin/screen/company/company_controller.dart';
import 'package:furniture_admin/static/bio_input_field.dart';
import 'package:furniture_admin/static/input_field.dart';
import 'package:furniture_admin/static/input_field1.dart';
import 'package:furniture_admin/static/large_button.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:furniture_admin/values/Validator.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({super.key});

  @override
  State<AddCompanyScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompanyController>(
      builder: (companyController) => Scaffold(
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
                GestureDetector(
                    onTap: () {
                      companyController.pickImage();
                    },
                    child: companyController.companyImage == null
                        ? Container(
                            width: MediaQuery.of(context).size.width,
                            height: 104,
                            decoration: ShapeDecoration(
                              color: Color(0x11823E13),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFF823E14)),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/addcompanyy.png')),
                                ),
                                Text(
                                  'Upload Photo',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )
                        : Container(
                            child: Image.file(
                              File(companyController.companyImage!.path),
                              fit: BoxFit.contain,
                            ),
                            color: Colors.blue,
                          )),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Company name',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                InputField(
                  validate: companyController.validateCompanyUpForm,
                  validator: (field) =>
                      Validators.emptyStringValidator(field, '*Comapany name'),
                  controller: companyController.name,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Bio in english',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                BioInputField(
                  validate: companyController.validateCompanyUpForm,
                  validator: (field) =>
                      Validators.emptyStringValidator(field, '*Bio in English'),
                  controller: companyController.englishBio,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Bio in arabic',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                BioInputField(
                  validate: companyController.validateCompanyUpForm,
                  validator: (field) =>
                      Validators.emptyStringValidator(field, '*Bio in arabic'),
                  controller: companyController.arabicBio,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Working Hours',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    companyController.selectTimeRange();
                  },
                  child: Container(
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
                              Text(formattedTime(companyController.startTime)),
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
                              Text(formattedTime(companyController.endTime)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: LargeButton(
                      title: 'Add',
                      onPressed: () {
                        companyController.addCompany();
                      }),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
