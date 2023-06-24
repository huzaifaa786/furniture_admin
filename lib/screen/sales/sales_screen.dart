// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furniture_admin/models/company.dart';
import 'package:furniture_admin/screen/sales/comapny_sale.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:get/get.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        children: [
          TopBar(
            ontap: () {
              Get.back();
            },
            text: 'Sales',
          ),
          Flexible(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.94,
              child: ListView.builder(
                itemCount: companies.length,
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return ClipRRect(
                    // borderRadius: BorderRadius.circular(50),
                    child: Card(
                      elevation: 3,
                      margin: EdgeInsets.only(
                          top: 10, bottom: 10, left: 1, right: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(company.imageUrl),
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
                          Get.to(() => CompanySalesScreen(company: company,));
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    )));
  }
}
