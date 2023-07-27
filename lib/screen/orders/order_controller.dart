import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:furniture_admin/models/order_model.dart';

import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  String? companyName;

  Stream<List<OrderModel>> getItemsStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        .orderBy('orderId', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
  }
}
