import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/user_controller.dart';
import 'package:hive/screens/utils/functions/random_char.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';

class GC_Controller extends GetxController {
  static GC_Controller instance = Get.find();

  CollectionReference _gc_table =
      FirebaseFirestore.instance.collection('group_chat');
  List group_chats = [];
  // {'name': 'Group Chat', 'image': 'sample.jpg', 'code': 'great'},
  // {'name': 'Hive', 'image': 'default_gc.png', 'code': 'neats'}

  List other_group_chats = [
    {'name': 'Creed Chat', 'image': 'sample.jpg', 'code': 'creed'},
    {'name': 'Breed Chat', 'image': 'default_gc.png', 'code': 'breed'}
  ];

  var gcDetails;

  get gc_details => gcDetails;

  List get gc_list => group_chats;

  void addGC(String name, user_id) async {
    try {
      String code = generateCode(5);
      var timestamp = DateTime.now().microsecondsSinceEpoch;

      Map<String, dynamic> newGC = {
        'code': code,
        'name': name,
        'date_created': timestamp.toString(),
        'image': 'default_gc.png',
        'people': [user_id]
      };

      await _gc_table.doc(code).set(newGC);
      UserController.instance.updateUserGC(code, user_id);
      Snacks().snack_success('Hive Created!', 'New Hive: ${name} Created!');
    } catch (e) {
      Snacks().snack_failed('Hive Creation Failed!', 'Something went wrong');
    }
  }

  Future joinGC(String code) async {
    for (int i = 0; i < other_group_chats.length; i++) {
      print('Code ${other_group_chats[i]['code']} : ${code}');
      if (other_group_chats[i]['code'] == code) {
        group_chats.add(other_group_chats[i]);
        update();
        Snacks().snack_success('Hive Joined!',
            'New Hive: ${other_group_chats[i]['name']} Joined!');
        return true;
      } else {
        Snacks().snack_failed('Hive Join Failed!', 'Invalid Code');
        return false;
      }
    }
  }

  void getUserGroupChats(user_id) async {
    var query = await _gc_table.where("people", arrayContains: user_id).get();
    group_chats = query.docs;
    update();
  }

  void GetGCDetails(String code) async {
    var query = await _gc_table.where("code", isEqualTo: code).get();
    gcDetails = query.docs[0];
    update();
    // for (int i = 0; i < group_chats.length; i++) {
    //   print('Code ${group_chats[i]['code']} : ${code}');
    //   if (group_chats[i]['code'] == code) {
    //     var desired_gc_details = group_chats[i];
    //     gcDetails = desired_gc_details;
    //     update();
    //   }
    // }
  }
}
