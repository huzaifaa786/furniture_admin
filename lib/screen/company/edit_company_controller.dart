// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:furniture_admin/helper/general.dart';
import 'package:furniture_admin/helper/loading.dart';
import 'package:furniture_admin/models/company.dart';
import 'package:furniture_admin/screen/main_screen.dart/main.dart';
import 'package:furniture_admin/values/Validator.dart';
import 'package:furniture_admin/values/colors.dart';
import 'package:get/get.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class EditCompanyController extends GetxController {
  static EditCompanyController get instance => Get.find();
  final Company company;

  EditCompanyController({required this.company});

  RxBool validateCompanyUpForm = false.obs;

  List<Company> companies = <Company>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  TimeOfDay startDefault = TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endDefault = TimeOfDay(hour: 17, minute: 0);

  DateTime startTime = DateTime(2023, 6, 23, 09, 00);
  DateTime endTime = DateTime(2023, 6, 23, 17, 00);

  File? companyImage1;
  File? companyImage2;
  File? companyImage3;

  var name = TextEditingController();
  var englishBio = TextEditingController();
  var arabicBio = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    configEditScreen();
  }

  configEditScreen() {
    name.text = company.name;
    englishBio.text = company.englishBio;
    arabicBio.text = company.arabicBio;
    startDefault = TimeOfDay.fromDateTime(company.startTime);
    endDefault = TimeOfDay.fromDateTime(company.endTime);
    startTime = company.startTime;
    endTime = company.endTime;

    update();
  }

  Future pickImage1() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      companyImage1 = imageTemp;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImage2() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      companyImage2 = imageTemp;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImage3() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      companyImage3 = imageTemp;
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
        update();
      },
      onEndChange: (end) {
        endTime = formatTimeOfDay(end);
        update();
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

  Future<void> deleteCompany(id) async {
    try {
      LoadingHelper.show();
      print(id);
      await firestore.collection('companies').doc(id).delete();
      Get.offAll(() => HomeScreen());
      LoadingHelper.dismiss();
    } catch (e) {
      print(e);
      LoadingHelper.dismiss();
    }
  }

  Future<void> updateCompany() async {
    try {
      final bool isFormValid =
          Validators.emptyStringValidator(englishBio.text, '') == null &&
              Validators.emptyStringValidator(arabicBio.text, '') == null &&
              Validators.emptyStringValidator(name.text, '') == null;
      if (isFormValid) {
        LoadingHelper.show();
        DocumentReference docRef =
            firestore.collection('companies').doc(company.id);

// Define the data you want to update
        Map<String, dynamic> updatedData = {
          'name': name.text,
          'companyImage1': company.companyImage1,
          'companyImage2': company.companyImage2,
          'companyImage3': company.companyImage3,
          'startTime': startTime,
          'endTime': endTime,
          'englishBio': englishBio.text,
          'arabicBio': arabicBio.text,
        };

        if (companyImage1 != null) {
          String companyImageURL1 = await saveImagetoFirebase(companyImage1);
          updatedData['companyImage1'] = companyImageURL1;
        }

        if (companyImage2 != null) {
          String companyImageURL2 = await saveImagetoFirebase(companyImage2);
          updatedData['companyImage2'] = companyImageURL2;
        }

        if (companyImage3 != null) {
          String companyImageURL3 = await saveImagetoFirebase(companyImage3);
          updatedData['companyImage3'] = companyImageURL3;
        }

// Update the document with the new data
        await docRef.update(updatedData);

        if (docRef.id.isNotEmpty) {
          LoadingHelper.dismiss();
          Get.showSnackbar(
            GetSnackBar(
              title: 'Success',
              message: 'Company Updated Successfully',
              icon: const Icon(Icons.refresh),
              duration: const Duration(seconds: 3),
            ),
          );
          Get.to(() => HomeScreen());
          Get.delete<EditCompanyController>();
        } else {
          // Failed to store data
          print('Failed to store data.');
        }
      } else {
        showErrors();
      }
    } catch (e) {
      // Error occurred while storing data
      print('Error storing data: $e');
    }
  }

  String generateUniqueDocumentID() {
    // Example: Using DateTime to generate a unique ID
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  saveImagetoFirebase(image) async {
    firebase_storage.Reference ref = storage
        .ref()
        .child('company_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
    firebase_storage.UploadTask uploadTask = ref.putFile(File(image.path));
    firebase_storage.TaskSnapshot storageTaskSnapshot =
        await uploadTask.whenComplete(() => null);
    return await storageTaskSnapshot.ref.getDownloadURL();
  }

  void showErrors() {
    validateCompanyUpForm = true.obs;
    update();
  }

  @override
  void onClose() {
    name.dispose();
    arabicBio.dispose();
    englishBio.dispose();
    companyImage1 = null;
    companyImage2 = null;
    companyImage3 = null;
    super.onClose();
  }
}
