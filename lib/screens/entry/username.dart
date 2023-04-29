import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hive/controllers/auth_controller.dart';
import 'package:hive/screens/pages/home.dart';
import 'package:hive/screens/utils/screens/loading_screen.dart';
import 'dart:math';

import 'package:uuid/uuid.dart';

class Username extends StatefulWidget {
  Map<String, dynamic> user_details;
  Username({Key? key, required this.user_details}) : super(key: key);

  @override
  State<Username> createState() => _UsernameState();
}

class _UsernameState extends State<Username> {
  var username_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var user_details = widget.user_details;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  color: Color.fromRGBO(21, 21, 21, 1),
                ),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.15,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Container(
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("assets/img/logo.png"),
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                  Text(
                    'Hive',
                    style: TextStyle(
                        color: Color.fromRGBO(253, 197, 8, 1),
                        fontSize: 39,
                        fontFamily: 'Montserrat-SemiBold'),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  'Buzz with your Hive - ',
                  style: TextStyle(
                      color: Color.fromRGBO(253, 197, 8, 1),
                      fontSize: 17,
                      fontFamily: 'Montserrat-SemiBold',
                      fontWeight: FontWeight.w200),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Connect and Chat with Friends!',
                  style: TextStyle(
                      color: Color.fromRGBO(253, 197, 8, 1),
                      fontSize: 17,
                      fontFamily: 'Montserrat-SemiBold',
                      fontWeight: FontWeight.w200),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              //  TEXTFIELDS
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'What do you want to bee dubbed as in the hive?',
                  style: TextStyle(
                      color: Color.fromRGBO(21, 21, 21, 1),
                      fontSize: 20,
                      fontFamily: 'Montserrat-SemiBold',
                      fontWeight: FontWeight.w200),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          offset: Offset(1, 1),
                          spreadRadius: 7,
                          color: Colors.grey.withOpacity(0.2))
                    ]),
                child: TextField(
                  controller: username_controller,
                  cursorColor: Color.fromRGBO(253, 197, 8, 1),
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(fontFamily: 'Montserrat'),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(253, 197, 8, 1))),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.white))),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025),

              //TEXTFIELDS

              //Login BUTTON
              GestureDetector(
                onTap: () {
                  var user_id = '${username_controller.text}-${Uuid().v4()}';

                  user_details['user_id'] = user_id;
                  user_details['username'] = username_controller.text;
                  AuthController.instance.register(user_details);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoadingScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(253, 197, 8, 1),
                      borderRadius: BorderRadius.circular(18)),
                  child: Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Montserrat-SemiBold'),
                    ),
                  ),
                ),
              ),
              // LOGIN BUTTON
            ],
          )
        ],
      ),
    );
  }
}
