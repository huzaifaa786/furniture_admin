import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_admin/helper/loading.dart';

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
        .asyncMap((snapshot) async {
      List<OrderModel> orders = [];
      for (final doc in snapshot.docs) {
        String companyId = doc['companyId'];
        DocumentSnapshot companySnapshot = await FirebaseFirestore.instance
            .collection('companies')
            .doc(companyId)
            .get();
        String companyName = companySnapshot['name'];
        OrderModel order = OrderModel.fromSnapshotWithCompany(doc, companyName);
        orders.add(order);
      }
      return orders;
    });
  }

  void updateStatus(void Function(bool) callback, orderid, status,userid,companyId) async {
    LoadingHelper.show();

    var collection = FirebaseFirestore.instance.collection('orders');
    collection.doc(orderid).update({
      'status': status,
    }).then((_) {
      notificationCreated(userid, companyId, status, orderid);
      LoadingHelper.dismiss();
      return callback(true);
    }).catchError((error) {
      LoadingHelper.dismiss();
      return callback(false);
    });
  }

  notificationCreated(String userId, String companyId, int status, String orderId) async {
    try {
      LoadingHelper.show();
      String noti1 = 'Our Professional is on way.';
      String noti2 = 'Way to the delivery.';
      String noti3 = 'Order delivered successfully.';
      String notiId = DateTime.now().millisecondsSinceEpoch.toString();
      await FirebaseFirestore.instance.collection('notifications').doc(notiId).set({
        'id': notiId,
        'userId': userId,
        'companyId': companyId,
        'content': status == 1
            ? noti1
            : status == 2
                ? noti2
                : noti3,
        'orderId': orderId
      });
      LoadingHelper.dismiss();
      return true;
    } catch (e) {
      return false;
    }
  }
  // Stream<List<OrderModel>> getItemsStream() {
  //   return FirebaseFirestore.instance
  //       .collection('orders')
  //       .orderBy('orderId', descending: true)
  //       .snapshots()
  //       .map((snapshot) =>
  //           snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
  // }
}
