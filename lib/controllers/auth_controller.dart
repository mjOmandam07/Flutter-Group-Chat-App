import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/controllers/user_controller.dart';
import 'package:hive/screens/entry/login.dart';
import 'package:hive/screens/pages/home.dart';
import 'package:hive/screens/splash/splash_screen.dart';
import 'package:hive/screens/utils/screens/loading_screen.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  var email;
  get user_email => email;

  FirebaseAuth auth = FirebaseAuth.instance;
  UserController userController = Get.put(UserController());
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());

    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => Splash());
    } else {
      email = user.email;
      update();
      Get.offAll(Home());
    }
  }

  void register(user_details) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: user_details['email'], password: user_details['password']);
      userController.addUser(user_details);
    } catch (e) {
      Snacks().snack_failed('Account Creation Failed', e.toString());
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Snacks().snack_failed('Login Failed', e.toString());
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
