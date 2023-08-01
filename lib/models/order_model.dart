import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String? id;
  String? userId;
  String? companyId;
  int? amount;
  String? date;
  String? time;
  int? status;
  String? description;

  OrderModel({
    this.id,
    this.userId,
    this.companyId,
    this.amount,
    this.date,
    this.time,
    this.status,
    this.description,
  });

  OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    userId = data['userId'] ?? '';
    id = data["orderId"] ?? '';
    companyId = data['companyId'] ?? '';
    amount = data['amount'] ?? '';
    date = data['date'] ?? '';
    time = data['time'] ?? '';
    status = data['status'] ?? '';
    description = data['description'] ?? '';
  }
}
