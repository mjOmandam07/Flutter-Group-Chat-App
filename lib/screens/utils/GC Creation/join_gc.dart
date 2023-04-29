import 'package:flutter/material.dart';
import 'package:hive/controllers/gc_list_controller.dart';
import 'package:hive/controllers/user_controller.dart';
import 'package:hive/screens/pages/home.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';
import 'package:page_transition/page_transition.dart';

class JoinGC extends StatelessWidget {
  TextEditingController code_controller;
  JoinGC({Key? key, required this.code_controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        // margin: EdgeInsets.only(left: 20, right: 20),
        child: Text(
          '''Join a Hive now''',
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(253, 197, 8, 1),
              fontFamily: 'Montserrat',
              fontSize: 26),
        ),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      Text(
        'Enter Hive Code',
        style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 1),
            fontFamily: 'Montserrat-SemiBold',
            fontSize: 20),
      ),
      Container(
        margin: EdgeInsets.all(20),
        child: TextField(
          controller: code_controller,
          maxLength: 5,
          cursorColor: Color.fromRGBO(253, 197, 8, 1),
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
          decoration: InputDecoration(
              hintText: "Hive Code",
              hintStyle: TextStyle(fontFamily: 'Montserrat'),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide:
                      BorderSide(color: Color.fromRGBO(253, 197, 8, 1))),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide:
                      BorderSide(color: Color.fromRGBO(253, 197, 8, 1)))),
        ),
      ),
      GestureDetector(
        onTap: () async {
          if (code_controller.text != '') {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
            Snacks().snack_wait();
            Future.delayed(const Duration(seconds: 1), () {
              GC_Controller.instance.joinGC(code_controller.text,
                  UserController.instance.user['user_id']);
              Navigator.pop(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: Home(),
                      duration: Duration(milliseconds: 600)));
            });
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.07,
          decoration: BoxDecoration(
              color: Color.fromRGBO(253, 197, 8, 1),
              borderRadius: BorderRadius.circular(18)),
          child: Center(
            child: Text(
              'Join Hive',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Montserrat-SemiBold'),
            ),
          ),
        ),
      ),
    ]);
  }
}
