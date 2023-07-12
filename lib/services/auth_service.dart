
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:furniture_admin/constants/constants.dart';
import 'package:furniture_admin/helper/loading.dart';
import 'package:furniture_admin/screen/auth/login_screen.dart';
import 'package:furniture_admin/screen/main_screen.dart/main.dart';
import 'package:get/get.dart';

class AuthService extends GetxController {
  static AuthService get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  String usersCollection = "users";

  //Will be load when app launches this func will be called and set the firebaseUser state
  @override
  void onReady() {
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  /// If we are setting initial screen from here
  /// then in the main.dart => App() add CircularProgressIndicator()
  _setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => const LoginScreen())
        : Get.offAll(() => const HomeScreen());
  }

  //FUNC
  Future<String?> createUserWithEmailAndPassword(
      String name, String email, String phone, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (firebaseUser.value != null) {
        String userID = firebaseUser.value!.uid;
        final token = await FirebaseMessaging.instance.getToken();
        try {
          await firebaseFirestore.collection(usersCollection).doc(userID).set({
            "id": userID,
            'token': token,
            "email": email.trim(),
            "name": email.trim(),
            "phone": phone.trim(),
          });
        } catch (e) {
          // Handle the error here
          print('Error occurred while setting data: $e');
          // You can also show an error message to the user or perform other actions as needed.
        }
        LoadingHelper.dismiss();
        Get.offAll(() => const HomeScreen());
      } else {
        Get.to(() => const LoginScreen());
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'Signup Failed';
    }
    return null;
  }

  _addUserToFirestore(String userID) async {}

  Future<String?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'login failed';
    }
    return null;
  }

  Future<void> logout() async => await _auth.signOut();
}
