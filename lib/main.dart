import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_admin/screen/chat/controller.dart';
import 'package:furniture_admin/helper/loading.dart';
import 'package:furniture_admin/screen/auth/login_controller.dart';
import 'package:furniture_admin/screen/auth/login_screen.dart';
import 'package:furniture_admin/screen/bugs/bug_controller.dart';
import 'package:furniture_admin/screen/main_screen.dart/main_controller.dart';
import 'package:furniture_admin/screen/orders/order_controller.dart';
import 'package:furniture_admin/screen/sales/salecontroller.dart';
import 'package:furniture_admin/screen/sales/sales_screen.dart';
import 'package:furniture_admin/screen/splash_screen/splash_screen.dart';
import 'package:furniture_admin/services/notification_service.dart';
import 'package:furniture_admin/values/styles.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoadingHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    // Get.put(AuthService());
    Get.put(LoginController());
    Get.put(MainController());
    Get.put(OrderController());
    Get.put(SaleController());
    Get.put(BugController());
    Get.put(NotificationService());
  });
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark, 
      child : MultiProvider(
      providers: [
        Provider<ChatProvider>(
          create: (_) => ChatProvider(
              // firebaseStorage: firebaseStorage,
              ),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(),
        theme: Styles.lightTheme,
        title: "Furniture Admin",
        initialRoute: 'splash',
        routes: {
          'splash': (_) => const SplashScreen(),
          'login': (_) => const LoginScreen(),
          'companysale': (_) => const SalesScreen(),
        },
      ),
    )
    );
  }
}
