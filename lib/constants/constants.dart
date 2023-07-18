import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:furniture_admin/screen/auth/login_controller.dart';
import 'package:furniture_admin/screen/company/company_controller.dart';
import 'package:furniture_admin/screen/company/edit_company_controller.dart';
import 'package:furniture_admin/screen/sales/salecontroller.dart';
import 'package:furniture_admin/services/auth_service.dart';

SaleController saleController = SaleController.instance;
LoginController loginController = LoginController.instance;
CompanyController companyController = CompanyController.instance;
EditCompanyController editcompanyController = EditCompanyController.instance;
AuthService authService = AuthService.instance;
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;