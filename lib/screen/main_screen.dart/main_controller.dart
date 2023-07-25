import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:get/get.dart';

import '../../helper/loading.dart';
import '../../services/auth_service.dart';
import '../../values/Validator.dart';

class MainController extends GetxController {
  static MainController get instance => Get.find();
  int chatlength = 0;
  count() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('messages')
        .where('companySeen', isEqualTo: false)
        .get();
    // Get the length of the document list
    chatlength = querySnapshot.docs.length;
    // Now, you can use the 'length' variable as needed
    print('Number of documents: $chatlength');
    update();
  }
}
