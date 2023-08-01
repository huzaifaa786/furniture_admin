import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_admin/models/bug_model.dart';



import 'package:get/get.dart';

class BugController extends GetxController {
  static BugController get instance => Get.find();


  Stream<List<BugModel>> getItemsStream() {
    print('ffffffffffffffffffffffff');
    return FirebaseFirestore.instance
        .collection('reports')
        .orderBy('id', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => BugModel.fromSnapshot(doc)).toList());
  }
}
