import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/controllers/gc_list_controller.dart';
import 'package:hive/screens/chats/chat.dart';
import 'package:hive/screens/utils/snackbars/snacks.dart';
import 'package:page_transition/page_transition.dart';

class GC_Details extends StatelessWidget {
  const GC_Details({super.key});

  @override
  Widget build(BuildContext context) {
    var codeController = TextEditingController();
    var snack = Snacks();
    var _gc_code =
        codeController.text = GC_Controller.instance.gc_details['code'];
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
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
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
                  image: AssetImage(
                      "assets/img/${GC_Controller.instance.gc_details['image']}"),
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
            // initialValue: 'QHWYSJK',
            cursorColor: Color.fromRGBO(253, 197, 8, 1),
            style: TextStyle(fontFamily: 'Montserrat-SemiBold', fontSize: 35),
            decoration: InputDecoration(
                enabled: false,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(253, 197, 8, 1))),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
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
      ]),
    );
  }
}
