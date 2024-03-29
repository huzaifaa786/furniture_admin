// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/models/order_model.dart';
import 'package:furniture_admin/screen/orders/order_card.dart';

import '../../values/colors.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? search;

  @override
  void initState() {
    orderController.getItemsStream(query: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 70,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                  // topLeft: Radius.circular(20),
                  // topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Center(
                child: Text(
              'Orders',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
              maxLines: null,
            )),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              onChanged: (String val) {
                search = val;
                orderController.getItemsStream(query: search);
                setState(() {});
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                hintText: 'Search order',
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: StreamBuilder<List<OrderModel>>(
                stream: orderController
                    .orderStream, // Use the stream you created to fetch data
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<OrderModel>? items = snapshot.data;
                    return ListView.builder(
                      itemCount: items!.length,
                      itemBuilder: (context, index) {
                        OrderModel item = items[index];
                        return OrderCard(
                            id: item.id,
                            amount: item.amount.toString(),
                            description: item.description,
                            date: item.date,
                            time: item.time,
                            companyName: item.companyName,
                            status: item.status,
                            user: item.userId,
                            company: item.companyId);
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      )),
    );
  }
}
