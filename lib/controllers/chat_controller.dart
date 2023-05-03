import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/user_controller.dart';
import 'package:hive/screens/utils/functions/random_char.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';

class Chat_Controller extends GetxController {
  static Chat_Controller instance = Get.find();
  CollectionReference _message_table =
      FirebaseFirestore.instance.collection('messages');

  get message_table => _message_table;

  var _chats;
  get chats => _chats;

  Future refreshMessages() async {
    _chats = null;
    update();
  }

  void addNewMessage(user_id, msg, code) async {
    try {
      var timestamp = FieldValue.serverTimestamp();
      var tstamp_local =
          '[${DateTime.now().microsecondsSinceEpoch.toString()} timezone: ${DateTime.now().timeZoneName}]';

      String unique_code = generateCode(5);

      Map<String, dynamic> newMsg = {
        'sender': user_id,
        'gc_code': code,
        'message': msg,
        'timestamp': timestamp,
      };

      await _message_table.doc('${user_id}-${tstamp_local}').set(newMsg);
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
