import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';

class GC_Controller extends GetxController {
  static GC_Controller instance = Get.find();
  List group_chats = [
    {'name': 'Group Chat', 'image': 'sample.jpg', 'code': 'great'},
    {'name': 'Hive', 'image': 'default_gc.png', 'code': 'neats'}
  ];

  List other_group_chats = [
    {'name': 'Creed Chat', 'image': 'sample.jpg', 'code': 'creed'},
    {'name': 'Breed Chat', 'image': 'default_gc.png', 'code': 'breed'}
  ];

  Map empty_details = {'name': '', 'image': '', 'code': ''};

  Map get gc_details => empty_details;

  List get gc_list => group_chats.reversed.toList();

  void addGC(String name) {
    int current_count = gc_list.length;

    Map newGC = {
      'name': name,
      'image': 'default_gc.png',
      'code': 'code${current_count++}'
    };
    group_chats.add(newGC);
    update();

    Snacks().snack_success('Hive Created!', 'New Hive: ${name} Created!');
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

  void GetGCDetails(String code) async {
    for (int i = 0; i < group_chats.length; i++) {
      print('Code ${group_chats[i]['code']} : ${code}');
      if (group_chats[i]['code'] == code) {
        var desired_gc_details = group_chats[i];
        empty_details = desired_gc_details;
        update();
      }
    }
  }
}
