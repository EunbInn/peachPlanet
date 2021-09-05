import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.only(top: 150)),
              SvgPicture.asset('images/IMG_Splash.svg'),
              Text('Login Success!')
            ],
          ),
        ),
      ),
    );
  }}