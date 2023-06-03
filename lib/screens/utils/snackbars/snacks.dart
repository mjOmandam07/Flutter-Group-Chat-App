import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class Snacks {
  SnackbarController snack_wait() {
    return Get.snackbar("", "Loading Message",
        backgroundColor: Color.fromRGBO(253, 197, 8, 1),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text('Loading'),
        messageText:
            Text('Please Wait...', style: TextStyle(color: Colors.white)));
    ;
  }

  SnackbarController snack_success(String title, String msgText) {
    return Get.snackbar("Success", "Success Message",
        backgroundColor: Color.fromARGB(255, 3, 143, 45),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(msgText, style: TextStyle(color: Colors.white)));
    ;
    ;
  }

  SnackbarController snack_failed(String title, String msgText) {
    return Get.snackbar("Failed", "Failed Message",
        backgroundColor: Color.fromARGB(255, 192, 1, 1),
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(msgText, style: TextStyle(color: Colors.white)));
    ;
    ;
  }

  SnackbarController connection_failed(String title, String msgText) {
    return Get.snackbar(
      "Failed",
      "Failed Message",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Color.fromARGB(255, 192, 1, 1),
      isDismissible: true,
      duration: Duration(days: 1),
      titleText: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      messageText: Text(msgText, style: TextStyle(color: Colors.white)),
    );
  }

  SnackbarController connection_success(String title, String msgText) {
    Get.closeCurrentSnackbar();
    return Get.snackbar("Success", "Success Message",
        backgroundColor: Color.fromARGB(255, 3, 143, 45),
        snackPosition: SnackPosition.TOP,
        titleText: Text(
          title,
          style: TextStyle(color: Colors.white),
        ),
        messageText: Text(msgText, style: TextStyle(color: Colors.white)));
    ;
    ;
  }
}
