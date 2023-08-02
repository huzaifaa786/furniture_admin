// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furniture_admin/screen/orders/status/status_model.dart';

import 'package:furniture_admin/values/colors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class OrderCard extends StatelessWidget {
  const OrderCard(
      {super.key,
      this.date,
      this.amount,
      this.id,
      this.description,
      this.time,
      this.companyName,
      this.company,
      this.user,
      this.status});
  final description;
  final date;
  final id;
  final amount;
  final status;
  final time;
  final companyName;
  final company;
  final user;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(5.0),
                              bottomRight: Radius.circular(5.0),
                              topLeft: Radius.circular(5.0),
                              topRight: Radius.circular(5.0),
                            ),
                            color: mainColor),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              SvgPicture.asset('assets/images/orderbucket.svg'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '#' + id,
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                description,
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          amount + ' AED',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: mainColor),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          onStatusUpdate(context, status, id,user,company);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.18,
                          height: 29.67,
                          decoration: ShapeDecoration(
                            color: Colors.black.withOpacity(0.8199999928474426),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            shadows: const [
                              BoxShadow(
                                color: Color(0x1E000000),
                                blurRadius: 50,
                                offset: Offset(20, 20),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Update',
                              maxLines: null,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  companyName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 2,
                  ),
                ),
                Text(
                  date + ' | ' + time,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 2,
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ],
    );
  }

  onStatusUpdate(context, status, id,user,comapny) {
    Alert(
        context: context,
        content: StatusScreen(status: status, id: id,userId: user,companyId: comapny),
        buttons: [
          DialogButton(
              height: 0, color: white, onPressed: () async {}, child: Text(''))
        ]).show();
  }
}
