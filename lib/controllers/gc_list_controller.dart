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

  List other_group_chats = [
    {'name': 'Creed Chat', 'image': 'sample.jpg', 'code': 'creed'},
    {'name': 'Breed Chat', 'image': 'default_gc.png', 'code': 'breed'}
  ];

  var gcDetails;
  get gc_details => gcDetails;

  List group_chats = [];
  List get gc_list => group_chats;

  var gc_update = true;
  get gc_refreshed => gc_update;

  void refresh_gc() {
    gc_update = false;
    group_chats = [];
    update();
  }

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
      UserController.instance.updateUserGC(code, name, user_id);
      Snacks().snack_success('Hive Created!', 'New Hive: ${name} Created!');
    } catch (e) {
      Snacks().snack_failed('Hive Creation Failed!', 'Something went wrong');
    }
  }

  void joinGC(String code, user_id) async {
    try {
      var query = await _gc_table.doc(code).get().then((value) async {
        var data = value.data() as Map<String, dynamic>;
        if (data['people'].contains(user_id)) {
          Snacks().snack_failed(
              'Hive Join Failed!', 'You are already a member of this Hive');
        } else {
          var new_item = [user_id];
          await _gc_table
              .doc(code)
              .update({"people": FieldValue.arrayUnion(new_item)});
          UserController.instance.updateUserGC(code, data['name'], user_id);
          Snacks().snack_success(
              'Hive Joined!', 'New Hive: ${data['name']} Joined!');
        }
      });
    } catch (e) {
      Snacks().snack_failed('Hive Join Failed!',
          'Something went wrong, Please Check your code if it is valid');
    }
  }

  void getUserGroupChats(user_id) async {
    try {
      var query = await _gc_table.where("people", arrayContains: user_id).get();
      group_chats = query.docs;
      gc_update = true;
      update();
    } catch (e) {
      Snacks().snack_failed('Problem in loading Hives', 'Something went wrong');
    }
  }

  Future GetGCDetails(String code) async {
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
