import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/auth_controller.dart';
import 'package:hive/controllers/connection_controller.dart';
import 'package:hive/controllers/gc_list_controller.dart';
import 'package:hive/controllers/user_controller.dart';
import 'package:hive/screens/chats/chat.dart';
import 'package:hive/screens/pages/home.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';
import 'package:page_transition/page_transition.dart';

class GC_Details extends StatefulWidget {
  const GC_Details({super.key});

  @override
  State<GC_Details> createState() => _GC_DetailsState();
}

class _GC_DetailsState extends State<GC_Details> {
  void LeaveHivedialog() {
    showDialog(
      context: context, barrierDismissible: true, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          elevation: 24.0,
          title: new Text(
            'Leaving this Hive?',
            style: TextStyle(fontFamily: 'Montserrat-SemiBold'),
          ),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  'Are you sure you want to buzz out from this Hive? We\'ll miss you and your honeycombed messages',
                  style: TextStyle(fontFamily: 'Montserrat'),
                ),
              ],
            ),
          ),
          actions: [
            Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255, 255, 1),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromRGBO(253, 197, 8, 1),
                      width: 0.8,
                    )),
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                    child: Text(
                      'Stay',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(253, 197, 8, 1),
                      ),
                    ))),
            Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 197, 8, 1),
                    borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                    onPressed: () {
                      Snacks().snack_wait();
                      Future.delayed(const Duration(seconds: 1), () async {
                        Get.offAll(Home());
                        await GC_Controller.instance.leaveGC(
                            GC_Controller.instance.gc_details,
                            UserController.instance.user['user_id']);
                      });
                    },
                    child: Text(
                      'Leave Hive',
                      style: TextStyle(
                          fontFamily: 'Montserrat-SemiBold',
                          color: Colors.white),
                    )))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var codeController = TextEditingController();
    var snack = Snacks();
    ConnectionController.instance.checkRealtimeConnection();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
              context,
            );
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: GetBuilder<GC_Controller>(builder: (_) {
        if (GC_Controller.instance.gc_details == null) {
          return Center(
              child: CircularProgressIndicator(
            backgroundColor: Color.fromRGBO(253, 197, 8, 1),
            color: Color.fromRGBO(21, 21, 21, 1),
          ));
        } else {
          codeController.text = GC_Controller.instance.gc_details['code'];
          return Column(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
              margin: EdgeInsets.all(15),
              padding: EdgeInsets.only(left: 11, top: 3),
              height: MediaQuery.of(context).size.height * 0.17,
              child: Center(
                child: Text(
                  'Tap to Change Photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color.fromRGBO(244, 209, 92, 1),
                      fontFamily: 'Montserrat-SemiBold',
                      fontSize: 26),
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  image: DecorationImage(
                      image: AssetImage("assets/img/sample.jpg"),
                      fit: BoxFit.cover)),
            ),
            Center(
              child: Text(
                GC_Controller.instance.gc_details['name'],
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(253, 197, 8, 1),
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w900,
                    fontSize: 40),
              ),
            ),
            Container(
              // margin: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                '''Spread the Buzz\nShare the Code''',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(253, 197, 8, 1),
                    fontFamily: 'Montserrat',
                    fontSize: 26),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: TextFormField(
                controller: codeController,
                textAlign: TextAlign.center,
                cursorColor: Color.fromRGBO(253, 197, 8, 1),
                style:
                    TextStyle(fontFamily: 'Montserrat-SemiBold', fontSize: 35),
                decoration: InputDecoration(
                    enabled: false,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide:
                            BorderSide(color: Color.fromRGBO(253, 197, 8, 1))),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.white))),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: codeController.text));

                snack.snack_success('Code Copied!', codeController.text);
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 197, 8, 1),
                    borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: Text(
                    'Copy',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Montserrat-SemiBold'),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            GestureDetector(
              onTap: () {
                LeaveHivedialog();
              },
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 0),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(253, 197, 8, 1),
                    borderRadius: BorderRadius.circular(18)),
                child: Center(
                  child: Text(
                    'Leave Hive',
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
      }),
    );
  }
}
