import 'package:flutter/gestures.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hive/controllers/auth_controller.dart';
import 'package:hive/screens/entry/register.dart';
import 'package:hive/screens/pages/home.dart';
import 'package:hive/screens/utils/screens/loading_screen.dart';
import 'package:page_transition/page_transition.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _email_controller = TextEditingController();
  var _password_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              //  TEXTFIELDS
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Email',
                  style: TextStyle(
                      color: Color.fromRGBO(21, 21, 21, 1),
                      fontSize: 17,
                      fontFamily: 'Montserrat-SemiBold',
                      fontWeight: FontWeight.w200),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
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
                  controller: _email_controller,
                  cursorColor: Color.fromRGBO(253, 197, 8, 1),
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  decoration: InputDecoration(
                      hintText: "Email",
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Password',
                  style: TextStyle(
                      color: Color.fromRGBO(21, 21, 21, 1),
                      fontSize: 17,
                      fontFamily: 'Montserrat-SemiBold',
                      fontWeight: FontWeight.w200),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
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
                  controller: _password_controller,
                  obscureText: true,
                  cursorColor: Color.fromRGBO(253, 197, 8, 1),
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 16),
                  decoration: InputDecoration(
                      hintText: "Password",
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
              //TEXTFIELDS

              //Login BUTTON
              GestureDetector(
                onTap: () {
                  AuthController.instance.login(_email_controller.text.trim(),
                      _password_controller.text.trim());
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoadingScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(left: 15, right: 15, top: 50),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(253, 197, 8, 1),
                      borderRadius: BorderRadius.circular(18)),
                  child: Center(
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Montserrat-SemiBold'),
                    ),
                  ),
                ),
              ),
              // LOGIN BUTTON

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
              // ALREADY HAVE AN ACCOUNT?
              Center(
                child: RichText(
                    text: TextSpan(
                        text: "Don't have an account?",
                        style: TextStyle(
                            color: Color.fromRGBO(21, 21, 21, 1),
                            fontSize: 18,
                            fontFamily: 'Montserrat-SemiBold'),
                        children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: Register(),
                                    duration: Duration(milliseconds: 600)));
                          },
                        text: " Register",
                        style: TextStyle(
                            color: Color.fromRGBO(253, 197, 8, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat'),
                      )
                    ])),
              )
              // ALREADY HAVE AN ACCOUNT?
            ],
          )
        ],
      ),
    );
  }
}
