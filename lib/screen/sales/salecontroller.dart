import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furniture_admin/helper/loading.dart';
import 'package:furniture_admin/models/company.dart';
import 'package:furniture_admin/models/order_model.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class SaleController extends GetxController {
  static SaleController instance = Get.find();
  CalendarFormat format = CalendarFormat.month;
  var format1 = 'month';
  DateTime ourdate = DateTime.now();
  DateTime today = DateTime.now();

  void onFormatChanged(DateTime date) {
    today = date;
    ourdate = date;
    update();
  }

  void onDaySelected(DateTime day, DateTime foucsedDay) async {
    today = day;
    ourdate = day;
    getsale();
    update();
  }

  // bool _shouldFetchCompanies = false;
  List<Company> companies = <Company>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchCompanies() async {
    try {
      LoadingHelper.show();
      QuerySnapshot querySnapshot =
          await firestore.collection('companies').get();

      List<Company> fetchedCompanies = querySnapshot.docs.map((doc) {
        print(List<Company>);
        return Company(
          id: doc.id,
          companyImage1: doc['companyImage1'],
          companyImage2: doc['companyImage2'],
          companyImage3: doc['companyImage3'],
          startTime: (doc['startTime'] as Timestamp).toDate(),
          endTime: (doc['endTime'] as Timestamp).toDate(),
          englishBio: doc['englishBio'],
          arabicBio: doc['arabicBio'],
          name: doc['name'],
        );
      }).toList();

      companies = fetchedCompanies;
      print(companies);
      update();
      LoadingHelper.dismiss();
    } catch (e) {
      print('Error fetching companies: $e');
    }
  }

  List<OrderModel> orders = <OrderModel>[].obs;

  Future<void> fetchSale(id) async {
    try {
      LoadingHelper.show();
      QuerySnapshot querySnapshot = await firestore
          .collection('orders')
          .where('companyId', isEqualTo: id)
          .get();

      List<OrderModel> fetchSale = querySnapshot.docs.map((doc) {
        print(List<OrderModel>);
        return OrderModel(
            id: doc['orderId'],
            userId: doc['userId'],
            companyId: doc['companyId'],
            amount: doc['amount'],
            date: doc['date'],
            time: doc['time'],
            status: doc['status'],
            description: doc['description']);
      }).toList();

      orders = fetchSale;
      update();
      LoadingHelper.dismiss();
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  int sum = 0;

  int getsale() {
    List<OrderModel> fetchSales;
    fetchSales = orders;
    sum = 0;
    for (var sale in orders) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(sale.id!));
      DateTime formattedDate = DateTime.utc(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0);
      if (formattedDate.toUtc() == today.toUtc()) {
        sum += sale.amount!;
      }
    }
    update();
    return sum;
  }
}
