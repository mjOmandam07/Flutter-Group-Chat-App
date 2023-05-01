import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/user_controller.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';

class Chat_Controller extends GetxController {
  static Chat_Controller instance = Get.find();
  CollectionReference _message_table =
      FirebaseFirestore.instance.collection('messages');
  var _chats;
  // {
  //   'sender': 'Oswng',
  //   'msg_payload': 'Hi its me Oswng!',
  //   'datetime': '8:42 AM 4/22/23'
  // },
  // {
  //   'sender': 'John',
  //   'msg_payload': 'Latest Message!, Hi its me John!',
  //   'datetime': '8:44 AM 4/22/23'
  // }

  get chats => _chats;

  Future refreshMessages() async {
    _chats = null;
    update();
  }

  void addNewMessage(user_id, msg, code) async {
    try {
      var timestamp = DateTime.now().microsecondsSinceEpoch;

      Map<String, dynamic> newMsg = {
        'sender': user_id,
        'gc_code': code,
        'message': msg,
        'timestamp': timestamp.toString(),
      };

      await _message_table
          .doc('${user_id}-${timestamp.toString()}')
          .set(newMsg);
      getMessages(code);
    } catch (e) {
      Snacks().snack_failed('Message Send Failed', 'Something went wrong');
    }
  }

  void getMessages(code) async {
    var query = await _message_table
        .where("gc_code", isEqualTo: code)
        .orderBy('timestamp')
        .get();
    _chats = query.docs.reversed.toList();
    update();
  }
}
