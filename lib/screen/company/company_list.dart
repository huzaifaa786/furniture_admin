import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:furniture_admin/screen/company/company_controller.dart';
import 'package:furniture_admin/screen/company/edit_company_controller.dart';
import 'package:furniture_admin/screen/company/edit_company_screen.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:get/get.dart';

class ComapanyList extends StatefulWidget {
  const ComapanyList({super.key});

  @override
  State<ComapanyList> createState() => _ComapanyListState();
}

class _ComapanyListState extends State<ComapanyList> {

  final CompanyController companyController = Get.put(CompanyController());

  @override
  void initState() {
    super.initState();
    companyController.enableFetchCompanies(); // Call your function from the controller here
  }

  @override
  Widget build(BuildContext context) {
    return   GetBuilder<CompanyController>(
      builder: (companyController) {
        return Scaffold(
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left:15.0,right: 15.0),
              child: Column(
                children: [
                  TopBar(
                    ontap: () {
                      Get.back();
                    },
                    text: 'Companies',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.94,
                      child: ListView.builder(
                        itemCount: companyController.companies.length,
                        itemBuilder: (context, index) {
                          final company = companyController.companies[index];
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
                                      color: Color(0x21000000),
                                      blurRadius: 28,
                                      offset: Offset(2, 2),
                                      spreadRadius:0,
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
                                        child: CachedNetworkImage(imageUrl : company.companyImage1,fit: BoxFit.fill,),
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
                                        Get.put(EditCompanyController(company: company));
                                    Get.to(() => EditCompanyScreen());
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
            )));
  });
  }
}