import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
      child: Center(
          child: Container(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(
          backgroundColor: Color.fromRGBO(253, 197, 8, 1),
          color: Color.fromRGBO(21, 21, 21, 1),
        ),
      )),
    );
    ;
  }
}
