import 'package:get/get.dart';

class Chat_Controller extends GetxController {
  List _chats = [
    {
      'sender': 'Mary',
      'msg_payload': 'Hi its me Mary!',
      'datetime': '8:40 AM 4/22/23'
    },
    {
      'sender': 'Oswng',
      'msg_payload': 'Hi its me Oswng!',
      'datetime': '8:42 AM 4/22/23'
    },
    {
      'sender': 'John',
      'msg_payload': 'Latest Message!, Hi its me John!',
      'datetime': '8:44 AM 4/22/23'
    }
  ];

  List get chats => _chats.reversed.toList();
  void addNewMessage(String msg) {
    Map message = {
      'sender': 'Oswng',
      'msg_payload': msg,
      'datetime': '8:44 AM 4/22/23'
    };

    _chats.add(message);
    update();
  }
}
