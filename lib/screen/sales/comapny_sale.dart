// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/models/company.dart';
import 'package:furniture_admin/screen/sales/salecontroller.dart';
import 'package:furniture_admin/static/topbar.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class CompanySalesScreen extends StatefulWidget {
  const CompanySalesScreen({super.key,this.company});
  // final String? id;
  final Company? company;

  @override
  State<CompanySalesScreen> createState() => _CompanySalesScreenState();
}

class _CompanySalesScreenState extends State<CompanySalesScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SaleController>(
      builder: (controller) => Scaffold(
        body: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  TopBar(
                    text: widget.company!.name,
                    ontap: () {
                      Get.back();
                    },
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TableCalendar(
                                selectedDayPredicate: (day) =>
                                    isSameDay(day, saleController.today),
                                firstDay: DateTime.utc(2023, 1, 1),
                                lastDay: DateTime.now(),
                                focusedDay: saleController.today,
                                onDaySelected: saleController.onDaySelected,
                                calendarStyle: CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                      color: mainColor.withOpacity(0.5),
                                      shape: BoxShape.circle),
                                  selectedDecoration: BoxDecoration(
                                      color: mainColor, shape: BoxShape.circle),
                                  markerDecoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  isTodayHighlighted: true,
                                  outsideDaysVisible: false,
                                ),
                                availableCalendarFormats: const {
                                  CalendarFormat.month: 'Month',
                                  // CalendarFormat.week: 'Week',
                                },
                                onPageChanged: saleController.onFormatChanged,
                                calendarFormat: saleController.format,
                                onFormatChanged: (CalendarFormat format) {
                                  setState(() {
                                    format == CalendarFormat.week
                                        ? saleController.format1 = 'week'
                                        : saleController.format1 = 'month';
                                    saleController.format = format;
                                    // saleController.getSlaes();
                                  });
                                },
                                startingDayOfWeek: StartingDayOfWeek.monday,
                                daysOfWeekVisible: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 23),
                    child: Text('Total Sales',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.only(top: 40, bottom: 40),
                    decoration: BoxDecoration(
                        color: mainColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(13)),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          saleController.price.toString() + ' AED',
                          style: TextStyle(
                              color: mainColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w600),
                        )),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
