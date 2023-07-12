
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:furniture_admin/helper/loading.dart';
import 'package:furniture_admin/screen/auth/login_controller.dart';
import 'package:furniture_admin/screen/auth/login_screen.dart';
import 'package:furniture_admin/screen/sales/sales_screen.dart';
import 'package:furniture_admin/screen/splash_screen/splash_screen.dart';
import 'package:furniture_admin/services/auth_service.dart';
import 'package:furniture_admin/values/styles.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LoadingHelper.init();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) {
    Get.put(AuthService());
    Get.put(LoginController());
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
    return GetMaterialApp(
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
    );
  }
}
