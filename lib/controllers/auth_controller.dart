import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/controllers/chat_controller.dart';
import 'package:hive/controllers/connection_controller.dart';
import 'package:hive/controllers/gc_list_controller.dart';
import 'package:hive/controllers/image_controller.dart';
import 'package:hive/controllers/user_controller.dart';
import 'package:hive/screens/entry/login.dart';
import 'package:hive/screens/entry/register.dart';
import 'package:hive/screens/pages/home.dart';
import 'package:hive/screens/splash/splash_screen.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;

  FirebaseAuth auth = FirebaseAuth.instance;
  UserController userController = Get.put(UserController());
  GC_Controller gcController = Get.put(GC_Controller());
  Chat_Controller chat_controller = Get.put(Chat_Controller());
  ImageController imageController = Get.put(ImageController());
  ConnectionController connectionController = Get.put(ConnectionController());

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());

    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => Splash());
    } else {
      // GC_Controller.instance.refresh_gc();
      await UserController.instance.getUserByEmail(user.email);
      Get.offAll(Home());
    }
  }

  void register(user_details) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: user_details['email'], password: user_details['password']);
      userController.addUser(user_details);
    } catch (e) {
      Get.to(() => Register());
      Snacks().snack_failed('Account Creation Failed', e.toString());
    }
  }

  void login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.to(() => Login());
      Snacks().snack_failed('Login Failed', e.toString());
    }
  }

  void logout() async {
    await auth.signOut();
  }
}
