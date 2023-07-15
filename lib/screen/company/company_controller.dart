import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_admin/helper/general.dart';
import 'package:furniture_admin/helper/loading.dart';
import 'package:furniture_admin/screen/main_screen.dart/main.dart';
import 'package:furniture_admin/values/Validator.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class CompanyController extends GetxController {
  static CompanyController get instance => Get.find();

 RxBool validateCompanyUpForm = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  TimeOfDay startDefault = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endDefault = TimeOfDay(hour: 17, minute: 0);

  DateTime startTime = DateTime(2023, 6, 23, 09, 00);
  DateTime endTime = DateTime(2023, 6, 23, 17, 00);

  File? companyImage;
  final name = TextEditingController();
  final englishBio = TextEditingController();
  final arabicBio = TextEditingController();


  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      companyImage = imageTemp;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  selectTimeRange() async {
    TimeRange result = await showTimeRangePicker(
      context: Get.context!,
      start: startDefault,
      end: endDefault,
      onStartChange: (start) {
        startTime = formatTimeOfDay(start);
      },
      onEndChange: (end) {
        endTime = formatTimeOfDay(end);
      },
      interval: const Duration(hours: 1),
      minDuration: const Duration(hours: 1),
      use24HourFormat: false,
      padding: 30,
      strokeWidth: 20,
      handlerRadius: 14,
      strokeColor: mainColor,
      handlerColor: mainColor.withOpacity(0.8),
      selectedColor: Colors.amber,
      backgroundColor: Colors.black.withOpacity(0.3),
      ticks: 12,
      ticksColor: Colors.white,
      snap: true,
      labels: ["12 am", "3 am", "6 am", "9 am", "12 pm", "3 pm", "6 pm", "9 pm"]
          .asMap()
          .entries
          .map((e) {
        return ClockLabel.fromIndex(idx: e.key, length: 8, text: e.value);
      }).toList(),
      labelOffset: -30,
      labelStyle: const TextStyle(
          fontSize: 22, color: Colors.grey, fontWeight: FontWeight.bold),
      timeTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
      activeTimeTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold),
    );
    print("result " + result.toString());
  }

  Future<void> addCompany() async {
    try {
    final bool isFormValid =  Validators.emptyStringValidator(englishBio.text, '') == null &&
          Validators.emptyStringValidator(arabicBio.text,'') == null &&
          Validators.emptyStringValidator(name.text,'') == null &&
          Validators.emptyStringValidator(companyImage!.path, '') == null ;
        if(isFormValid) {
          LoadingHelper.show();
      firebase_storage.Reference ref = storage
          .ref()
          .child('company_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      firebase_storage.UploadTask uploadTask =
          ref.putFile(File(companyImage!.path));
      firebase_storage.TaskSnapshot storageTaskSnapshot =
          await uploadTask.whenComplete(() => null);
      String companyImageURL = await storageTaskSnapshot.ref.getDownloadURL();
      DocumentReference docRef = await firestore.collection('companies').add({
        'name': name.text,
        'companyImage': companyImageURL,
        'startTime': startTime,
        'endTime': endTime,
        'englishBio': englishBio.text,
        'arabicBio': arabicBio.text,
      });

      if (docRef.id.isNotEmpty) {
        LoadingHelper.dismiss();
        Get.showSnackbar(
          GetSnackBar(
            title: 'Success',
            message: 'Company Registered Successfully',
            icon: const Icon(Icons.refresh),
            duration: const Duration(seconds: 3),
          ),
        );
        Get.to(() => HomeScreen());
      } else {
        // Failed to store data
        print('Failed to store data.');
      }
        }else{
          showErrors();
        }
    } catch (e) {
      // Error occurred while storing data
      print('Error storing data: $e');
    }
  }

    void showErrors() {
    validateCompanyUpForm = true.obs;
    update();
  }


  @override
  void onClose() {
    // email.dispose();
    // password.dispose();
    super.onClose();
  }
}
