import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furniture_admin/screen/company/company_controller.dart';
import 'package:get/get.dart';

class CompanyPhotoPicker extends StatelessWidget {
   CompanyPhotoPicker({this.comapnyImage,required this.pickImage,super.key});
  final File? comapnyImage;
  final  pickImage; 

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompanyController>(
      builder: (companyController) => GestureDetector(
          onTap: this.pickImage,
          child: comapnyImage == null
              ? Container(
                  margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 130,
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              : Container(
                  margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 130,
                  decoration: ShapeDecoration(
                    color: Color(0x11823E13),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF823E14)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      File(comapnyImage!.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                )),
    );
  }
}
