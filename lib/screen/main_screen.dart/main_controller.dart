import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

class MainController extends GetxController {
  static MainController get instance => Get.find();
  int chatlength = 0;
  int reportlength = 0;

  count() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('messages')
        .where('companySeen', isEqualTo: false)
        .get();
    chatlength = querySnapshot.docs.length;
    print('Number of documents: $chatlength');
    update();
  }

  reportCount() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('reports')
        .where('seen', isEqualTo: false)
        .get();
    reportlength = querySnapshot.docs.length;
    print('Number of document: $reportlength');
    update();
  }
}
