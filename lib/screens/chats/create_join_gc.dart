import 'package:flutter/material.dart';

import 'package:hive/screens/pages/home.dart';
import 'package:hive/screens/utils/GC%20Creation/create_gc.dart';
import 'package:hive/screens/utils/GC%20Creation/join_gc.dart';
import 'package:page_transition/page_transition.dart';

class CreateGroupChat extends StatefulWidget {
  const CreateGroupChat({super.key});

  @override
  State<CreateGroupChat> createState() => _CreateGroupChatState();
}

class _CreateGroupChatState extends State<CreateGroupChat> {
  var _current_btn = 'Join Hive';

  void SetGCWidget() {
    setState(() {
      if (_current_btn == 'Join Hive') {
        _current_btn = 'Create Hive';
      } else {
        _current_btn = 'Join Hive';
      }
    });
  }

  var codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: Home(),
                    duration: Duration(milliseconds: 600)));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          child: Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              'No Hive?',
              style: TextStyle(
                  color: Color.fromRGBO(253, 197, 8, 1),
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w900,
                  fontSize: 70),
            ),
            if (_current_btn == 'Join Hive')
              CreateGC(
                code_controller: codeController,
              ),
            if (_current_btn == 'Create Hive')
              JoinGC(
                code_controller: codeController,
              ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 25, bottom: 15, left: 14),
                child: Row(children: [
                  Container(
                      color: Color.fromRGBO(253, 197, 8, 1),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.001),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'OR',
                      style: TextStyle(
                          color: Color.fromRGBO(253, 197, 8, 1),
                          fontSize: 17,
                          fontFamily: 'Montserrat-SemiBold',
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                      color: Color.fromRGBO(253, 197, 8, 1),
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: MediaQuery.of(context).size.height * 0.001)
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                SetGCWidget();
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
                    '${_current_btn}',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat-SemiBold'),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
