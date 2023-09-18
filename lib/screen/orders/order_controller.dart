import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/helper/loading.dart';
import 'package:furniture_admin/models/order_model.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  static OrderController get instance => Get.find();
  String? companyName;
  Stream<List<OrderModel>>? orderStream;

  Stream<List<OrderModel>> getItemsStream({String? query}) {
    if (query == null || query.isEmpty) {
      orderStream = FirebaseFirestore.instance
          .collection('orders')
          .orderBy('orderId', descending: true)
          .snapshots()
          .asyncMap((querySnapshot) async {
        List<OrderModel> orders = [];

        for (final doc in querySnapshot.docs) {
          final companyId = doc['companyId'];
          final companySnapshot = await FirebaseFirestore.instance
              .collection('companies')
              .doc(companyId)
              .get();
          final companyName = companySnapshot['name'];

          // Create an OrderModel with company name and other data
          final order = OrderModel.fromSnapshotWithCompany(doc, companyName);
          orders.add(order);
        }
        update();

        return orders;
      });
      update();
      return orderStream!;
    } else {
      print(query);
      String queryLower = query.toLowerCase();
      String queryUpper = queryLower.substring(0, queryLower.length - 1) +
          String.fromCharCode(queryLower.codeUnitAt(queryLower.length - 1) + 1);
      orderStream = FirebaseFirestore.instance
          .collection('orders')
          .where('orderId',
              isGreaterThanOrEqualTo: queryLower, isLessThan: queryUpper)
          .orderBy('orderId', descending: true)
          .snapshots()
          .asyncMap((querySnapshot) async {
        update();
        List<OrderModel> orders = [];
        for (final doc in querySnapshot.docs) {
          final companyId = doc['companyId'];
          final companySnapshot = await FirebaseFirestore.instance
              .collection('companies')
              .doc(companyId)
              .get();
          final companyName = companySnapshot['name'];
          final order = OrderModel.fromSnapshotWithCompany(doc, companyName);
          orders.add(order);
        }
        update();
        return orders;
      });
      update();
      return orderStream!;
    }
    // return FirebaseFirestore.instance
    //     .collection('orders')
    //     .orderBy('orderId', descending: true)
    //     .snapshots()
    //     .asyncMap((snapshot) async {
    //   List<OrderModel> orders = [];
    //   for (final doc in snapshot.docs) {
    //     String companyId = doc['companyId'];
    //     DocumentSnapshot companySnapshot = await FirebaseFirestore.instance
    //         .collection('companies')
    //         .doc(companyId)
    //         .get();
    //     String companyName = companySnapshot['name'];
    //     OrderModel order = OrderModel.fromSnapshotWithCompany(doc, companyName);
    //     orders.add(order);
    //   }
    //   return orders;
    // });
  }

  void updateStatus(void Function(bool) callback, orderid, status, userid,
      companyId, token) async {
    LoadingHelper.show();

    var collection = FirebaseFirestore.instance.collection('orders');
    collection.doc(orderid).update({
      'status': status,
    }).then((_) {
      notificationCreated(userid, companyId, status, orderid, token);
      LoadingHelper.dismiss();
      return callback(true);
    }).catchError((error) {
      LoadingHelper.dismiss();
      return callback(false);
    });
  }

  notificationCreated(String userId, String companyId, int status,
      String orderId, String token) async {
    try {
      LoadingHelper.show();
      String noti1 = 'Our Professional is on way.';
      String noti2 = 'Way to the delivery.';
      String noti3 = 'Order delivered successfully.';
      String notiId = DateTime.now().millisecondsSinceEpoch.toString();
      status == 1
          ? notificationService.postNotification(
              title: 'Order(#$orderId) Status Updated',
              body: noti1,
              receiverToken: token)
          : status == 2
              ? notificationService.postNotification(
                  title: 'Order(#$orderId) Status Updated',
                  body: noti2,
                  receiverToken: token)
              : notificationService.postNotification(
                  title: 'Order(#$orderId) Status Updated',
                  body: noti3,
                  receiverToken: token);
      await FirebaseFirestore.instance
          .collection('notifications')
          .doc(notiId)
          .set({
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
      LoadingHelper.dismiss();
      return false;
    }
  }
}
