import 'package:flutter/material.dart';
import 'package:hive/screens/entry/login.dart';
import 'package:page_transition/page_transition.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromRGBO(21, 21, 21, 1),
        body: Container(
          height: h,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              height: h * 0.64,
              padding: EdgeInsets.only(top: h * 0.17),
              child: Column(children: [
                Text(
                  'Hive',
                  style: TextStyle(
                      color: Color.fromRGBO(253, 197, 8, 1),
                      fontWeight: FontWeight.w900,
                      fontSize: 45,
                      fontFamily: 'Montserrat'),
                ),
                Container(
                  width: w * 0.9,
                  height: h * 0.3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/logo.png"),
                          fit: BoxFit.cover)),
                )
              ]),
            ),
            Container(
              padding: EdgeInsets.all(h * 0.05),
              width: w,
              height: h * 0.36,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(253, 197, 8, 1),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              child: Column(children: [
                Text(
                  'Buzzing Conversations starts here',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 27,
                      fontFamily: 'Montserrat-SemiBold',
                      fontWeight: FontWeight.w200),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: h * 0.05,
                ),
                Container(
                  child: SwipeableButtonView(
                    indicatorColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(253, 197, 8, 1)),
                    buttonText: 'Swipe to start...',
                    buttontextstyle: TextStyle(
                        color: Color.fromRGBO(253, 197, 8, 1),
                        fontFamily: 'Montserrat-SemiBold',
                        fontSize: 20),
                    buttonColor: Color.fromRGBO(253, 197, 8, 1),
                    buttonWidget: Container(
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    activeColor: Colors.white,
                    isFinished: isFinished,
                    onWaitingProcess: () {
                      Future.delayed(Duration(seconds: 2), () {
                        setState(() {
                          isFinished = true;
                        });
                      });
                    },
                    onFinish: () async {
                      // await Navigator.pushReplacementNamed(
                      //     context, '/register');

                      await Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: Login(),
                              duration: Duration(milliseconds: 600)));

                      setState(() {
                        isFinished = false;
                      });
                    },
                  ),
                )
              ]),
            )
          ]),
        ));
  }
}
