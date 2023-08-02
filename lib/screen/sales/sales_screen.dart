// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/screen/sales/comapny_sale.dart';
import 'package:furniture_admin/screen/sales/salecontroller.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:get/get.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  void initState() {
    saleController
        .fetchCompanies(); // Call your function from the controller here
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GetBuilder<SaleController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          children: [
            TopBar(
              ontap: () {
                Get.back();
              },
              text: 'Sales',
            ),
            SizedBox(
              height: 10.0,
            ),
            Flexible(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.94,
                child: ListView.builder(
                  itemCount: saleController.companies.length,
                  itemBuilder: (context, index) {
                    final company = saleController.companies[index];
                    return ClipRRect(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Container(
                          height: 97,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(38),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                blurRadius: 28,
                                offset: Offset(2, 2),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.only(
                                top: 20, left: 15.0, right: 15.0, bottom: 20.0),
                            leading: SizedBox(
                              width: 60,
                              height: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  // constraints: const BoxConstraints(
                                  //   maxWidth: 300,
                                  //   maxHeight: 20,
                                  // ),
                                  color: Colors.green,
                                  child: Image.network(
                                    company.companyImage1,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              company.name,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            ),
                            trailing: Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 30,
                            ),
                            onTap: () {
                              saleController.clear();
                              Get.to(() => CompanySalesScreen(
                                    company: saleController.companies[index],
                                  ));
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
