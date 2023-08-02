// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/screen/orders/status/status_method.dart';
import 'package:furniture_admin/static/large_button.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({super.key, required this.status, required this.id,required this.userId,required this.companyId});

  final int? status;
  final String? id;
  final String? userId;
  final String? companyId;

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

enum statusMethod {
  rececied,
  markOrderAsProfessionalOnTheWay,
  onTheWayToTheDeliverTheItems,
  orderDeliveredSuccessfully
}

class _StatusScreenState extends State<StatusScreen> {
  statusMethod _site = statusMethod.rececied;
  toggleplan(statusMethod value) {
    setState(() {
      _site = value;
    });
  }

  val() async {
    _site = widget.status == 0
        ? statusMethod.rececied
        : widget.status == 1
            ? statusMethod.markOrderAsProfessionalOnTheWay
            : widget.status == 2
                ? statusMethod.onTheWayToTheDeliverTheItems
                : statusMethod.orderDeliveredSuccessfully;
    setState(() {});
  }

  @override
  void initState() {
    val();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Column(
            children: [
              StatusMethod(
                title: 'Mark order as Professional on the way',
                groupvalue: _site,
                value: statusMethod.markOrderAsProfessionalOnTheWay,
                onchaged: widget.status == 3
                    ? () {}
                    : () async {
                        await toggleplan(
                            statusMethod.markOrderAsProfessionalOnTheWay);
                      },
              ),
              StatusMethod(
                title: 'On the way to the deliver the items',
                groupvalue: _site,
                value: statusMethod.onTheWayToTheDeliverTheItems,
                onchaged: widget.status == 3
                    ? () {}
                    : () async {
                        await toggleplan(
                            statusMethod.onTheWayToTheDeliverTheItems);
                      },
              ),
              StatusMethod(
                title: 'Order delivered successfully',
                groupvalue: _site,
                value: statusMethod.orderDeliveredSuccessfully,
                onchaged: () async {
                  await toggleplan(statusMethod.orderDeliveredSuccessfully);
                },
              ),
              LargeButton(
                title: 'Update',
                color: widget.status == 3
                    ? mainColor.withOpacity(0.5)
                    : _site == statusMethod.rececied
                        ? mainColor.withOpacity(0.5)
                        : mainColor,
                onPressed: () {
                  widget.status == 3
                      ? () {}
                      : _site == statusMethod.rececied
                          ? () {}
                          : orderController.updateStatus((success) {
                              if (success) {
                                Get.back();
                                Get.snackbar('Status Updated Successfully.', '',
                                    backgroundColor: Colors.green,
                                    colorText: white,
                                    snackPosition: SnackPosition.BOTTOM);
                                // successModel(context);
                              }
                            },
                              widget.id,
                              _site == statusMethod.rececied
                                  ? 0
                                  : _site ==
                                          statusMethod
                                              .markOrderAsProfessionalOnTheWay
                                      ? 1
                                      : _site ==
                                              statusMethod
                                                  .onTheWayToTheDeliverTheItems
                                          ? 2
                                          : 3,
                              widget.userId,
                              widget.companyId);
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}
