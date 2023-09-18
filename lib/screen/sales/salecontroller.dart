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
  DateTime? rangeStart;
  DateTime? rangeEnd;

  void onFormatChanged(DateTime date) {
    today = date;
    ourdate = date;
    getsale();
    update();
  }

  void onDaySelected(DateTime day, DateTime foucsedDay) async {
    today = day;
    ourdate = day;
    getsale();
    update();
  }

  void onRangeSelected(start, end, focusedDay) {
    rangeStart = start;
    rangeEnd = end;
    today = focusedDay;
    ourdate = focusedDay;
    if (end == null) {
      getsale();
      ;
    } else {
      getSalesBySelectedRange(start, end);
    }
    update();
  }

  // bool _shouldFetchCompanies = false;
  List<Company> companies = <Company>[].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchCompanies() async {
    try {
      LoadingHelper.show();
      QuerySnapshot querySnapshot =
          await firestore.collection('companies').where('delete', isEqualTo: false).get();

      List<Company> fetchedCompanies = querySnapshot.docs.map((doc) {
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
          .where('status', isEqualTo: 3)
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
      orders = <OrderModel>[].obs;
      orders = fetchSale;
      getsale();
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
    for (var sale in fetchSales) {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(int.parse(sale.id!));
      DateTime formattedDate =
          DateTime.utc(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0, 0);
      DateTime formattedTodate =
          DateTime.utc(today.year, today.month, today.day, 0, 0, 0, 0);
      if (formattedDate.toUtc() == formattedTodate.toUtc()) {
        sum += sale.amount!;
      }
    }
    update();
    return sum;
  }

  int getSalesBySelectedRange(DateTime startDate, DateTime endDate) {
    List<OrderModel> fetchSales = orders;
    // print(fetchSales);
    sum = 0;
    DateTime formattedStartDate = DateTime.utc(
        startDate.year, startDate.month, startDate.day, 0, 0, 0, 0);
    DateTime formattedEndDate =
        DateTime.utc(endDate.year, endDate.month, endDate.day, 0, 0, 0, 0);
    for (var sale in fetchSales) {
      DateTime saleDate =
          DateTime.fromMillisecondsSinceEpoch(int.parse(sale.id!));
      DateTime formattedSaleDate =
          DateTime.utc(saleDate.year, saleDate.month, saleDate.day, 0, 0, 0, 0);
      if ((formattedSaleDate.isAfter(formattedStartDate) ||
              formattedSaleDate.isAtSameMomentAs(formattedStartDate)) &&
          (formattedSaleDate.isBefore(formattedEndDate) ||
              formattedSaleDate.isAtSameMomentAs(formattedEndDate))) {
        sum += sale.amount!;
      }
    }
    update();
    print(sum);
    return sum;
  }

  clear() {
    ourdate = DateTime.now();
    today = DateTime.now();
    sum = 0;
    rangeStart = null;
    rangeEnd = null;
    orders = [];
    update();
  }
}
