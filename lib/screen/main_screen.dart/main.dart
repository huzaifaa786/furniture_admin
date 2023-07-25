// ignore_for_file: deprecated_member_use, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_admin/chat/chat_view.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/screen/bugs/bugs.dart';
import 'package:furniture_admin/screen/company/add_company_screen.dart';
import 'package:furniture_admin/screen/company/company_controller.dart';
import 'package:furniture_admin/screen/company/company_list.dart';
import 'package:furniture_admin/screen/company/edit_company_controller.dart';
import 'package:furniture_admin/screen/company/edit_company_screen.dart';
import 'package:furniture_admin/screen/main_screen.dart/main_controller.dart';
import 'package:furniture_admin/screen/sales/sales_screen.dart';
import 'package:furniture_admin/static/main_card.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';
import '../chat/chat_view.dart';
import '../orders/orderscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int current = 0;
  List<String> imgList = [
    'https://cdn.shopify.com/s/files/1/0891/4784/articles/Top_12_Furniture_Store_in_Calgary_1024x1024.jpg?v=1663218020',
    'https://cdn.shopify.com/s/files/1/0891/4784/articles/Top_12_Furniture_Store_in_Calgary_1024x1024.jpg?v=1663218020',
    'https://cdn.shopify.com/s/files/1/0891/4784/articles/Top_12_Furniture_Store_in_Calgary_1024x1024.jpg?v=1663218020',
  ];
  chatCount() {
    mainController.count();
    setState(() {});
  }

  @override
  void initState() {
    chatCount();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: GetBuilder<MainController>(
      builder: (homeController) => Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, left: 12, right: 12, bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(45)),
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: InkWell(
                            onTap: () {
                              loginController.signOut();
                            },
                            child: CircleAvatar(
                              radius: 25.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage:
                                  AssetImage('assets/images/splashLogo.png'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(45)),
                        padding: EdgeInsets.all(2),
                        child: IconButton(
                          onPressed: () {
                            Get.to(() => BugsScreen())!.then((value) {
                              mainController.count();
                            });
                          },
                          icon: SvgPicture.asset(
                            'assets/images/bug.svg',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 12, right: 12),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.2,
                        autoPlay: true,
                        viewportFraction: 1,
                        enlargeCenterPage: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            current = index;
                          });
                        },
                      ),
                      items: imgList.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: CachedNetworkImage(
                                imageUrl: i,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.asMap().entries.map((entry) {
                      int index = entry.key;
                      return Container(
                        width: current == index ? 30.0 : 10.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: current == index
                                ? Color.fromRGBO(0, 0, 0, 0.8)
                                : Color.fromRGBO(0, 0, 0, 0.3)),
                      );
                    }).toList(),
                  ),
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.only(top: 16),
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.5 / 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 20),
                        children: [
                          MainCard(
                            image: 'assets/images/addCompany.svg',
                            title: 'Add Comapny',
                            ontap: () {
                              Get.put(CompanyController());

                              Get.to(() => AddCompanyScreen())!.then((value) {
                                mainController.count();
                              });
                            },
                          ),
                          MainCard(
                            image: 'assets/images/sales.svg',
                            title: 'Sales',
                            ontap: () {
                              Get.to(() => SalesScreen());
                            },
                          ),
                          MainCard(
                            image: 'assets/images/edit.svg',
                            title: 'Edit Comapny',
                            ontap: () {
                              Get.to(() => ComapanyList())!.then((value) {
                                mainController.count();
                              });
                            },
                          ),
                          MainCard(
                            image: 'assets/images/document.svg',
                            title: 'Orders',
                            ontap: () {
                              Get.to(() => OrderScreen())!.then((value) {
                                mainController.count();
                              });
                            },
                          ),
                          MainCard(
                            image: 'assets/images/chat1.svg',
                            title: 'All Chats',
                            badgeValue: mainController.chatlength.toString(),
                            ontap: () {
                              Get.to(() => ChatLsitScreen())!.then((value) {
                                mainController.count();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.64,
          //   child: ListView.builder(
          //     itemCount: companies.length,
          //     itemBuilder: (context, index) {
          //       final company = companies[index];
          //       return Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          //         child: ClipRRect(
          //           borderRadius: BorderRadius.circular(50),
          //           child: Card(
          //             elevation: 3,
          //             margin: EdgeInsets.all(10),
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(30.0),
          //             ),
          //             child: ListTile(
          //               contentPadding: EdgeInsets.all(10),
          //               leading: Container(
          //                 width: 60,
          //                 height: 60,
          //                 decoration: BoxDecoration(
          //                   shape: BoxShape.circle,
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.black.withOpacity(0.2),
          //                       blurRadius: 8,
          //                       offset: Offset(0, 4),
          //                     ),
          //                   ],
          //                 ),
          //                 child: CircleAvatar(
          //                   radius: 10,
          //                   backgroundColor: Colors.transparent,
          //                   child: ClipRRect(
          //                     borderRadius: BorderRadius.circular(10),
          //                     child: Image.asset('assets/images/splashLogo.png'),
          //                   ),
          //                 ),
          //               ),
          //               title: Text(
          //                 company.name,
          //                 style: TextStyle(
          //                     fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          //               ),
          //               subtitle: Row(
          //                 children: [
          //                   Icon(
          //                     Icons.star,
          //                     size: 16,
          //                     color: ratingColor,
          //                   ),
          //                   SizedBox(width: 4),
          //                   Text(company.starRating.toString()),
          //                 ],
          //               ),
          //               trailing: Icon(
          //                 Icons.arrow_circle_right_outlined,
          //                 size: 30,
          //               ),
          //               onTap: () {
          //                 Get.to(() => CompanyProfileScreen(company: company));
          //                 // Handle the tap on the list item
          //                 // You can navigate to the detail screen or perform any other action
          //               },
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    )));
  }
}
