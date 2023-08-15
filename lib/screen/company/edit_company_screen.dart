// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/helper/general.dart';
import 'package:furniture_admin/models/company.dart';
import 'package:furniture_admin/screen/company/edit_company_controller.dart';
import 'package:furniture_admin/static/bio_input_field.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:furniture_admin/static/edit_company_photo.dart';
import 'package:furniture_admin/static/input_field.dart';
import 'package:furniture_admin/static/large_button.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:furniture_admin/values/Validator.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditCompanyScreen extends StatefulWidget {
  const EditCompanyScreen({super.key, required this.company});
  final Company? company;

  @override
  State<EditCompanyScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<EditCompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditCompanyController>(
      builder: (companyController) => Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 10, right: 20, left: 20),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                TopBar(
                  text: ' Edit Company',
                  ontap: () {
                    Get.back();
                  },
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      EditCompanyPhotoPicker(
                          comapnyImage: companyController.companyImage1,
                          pickImage: companyController.pickImage1,
                          originalImage:
                              companyController.company.companyImage1),
                      EditCompanyPhotoPicker(
                          comapnyImage: companyController.companyImage2,
                          pickImage: companyController.pickImage2,
                          originalImage:
                              companyController.company.companyImage2),
                      EditCompanyPhotoPicker(
                          comapnyImage: companyController.companyImage3,
                          pickImage: companyController.pickImage3,
                          originalImage:
                              companyController.company.companyImage3),
                    ],
                  ),
                ),
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
                      title: 'Update',
                      onPressed: () {
                        companyController.updateCompany();
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 20),
                  child: LargeButton(
                      title: 'Delete',
                      color: const Color.fromARGB(255, 202, 34, 22),
                      onPressed: () {
                        print(companyController.company.id);
                        delete(context, companyController.company.id);
                        // companyController.deleteCompany();
                      }),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  delete(context, id) {
    Alert(
      style: const AlertStyle(
        titleStyle: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
      ),
      context: context,
      image: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SvgPicture.asset('assets/images/logout.svg'),
      ),
      title: "Are you sure you want to this company?",
      buttons: [
        DialogButton(
          height: 55,
          radius: BorderRadius.circular(13),
          child: Text(
            "Yes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            editcompanyController.deleteCompany(id);
          },
          color: mainColor,
        ),
        DialogButton(
          height: 55,
          radius: BorderRadius.circular(13),
          border: Border.all(
            color: Colors.black54,
          ),
          child: Text(
            "No",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600),
          ),
          onPressed: () {
            Get.back();
          },
          color: Colors.black,
        ),
      ],
    ).show();
  }
}
