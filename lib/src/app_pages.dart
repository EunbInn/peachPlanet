import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peach_planet_test/src/ui/MailCheckSuccessPage.dart';
import 'package:peach_planet_test/src/ui/loginPage.dart';
import 'package:peach_planet_test/src/ui/mailCheckPage.dart';
import 'package:peach_planet_test/src/ui/mainPage.dart';
import 'package:peach_planet_test/src/ui/selectSchool.dart';
import 'package:peach_planet_test/src/ui/splashPage.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => SplashPage(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(), transition: Transition.fadeIn,

    ),
    GetPage(
      name: '/selectSchool',
      page: () => SelectSchoolPage(),
    ),
    GetPage(
      name: '/mainPage',
      page: () => MainPage(),
    ),
    GetPage(
      name: '/mailCheckPage',
      page: () => MailCheckPage(),
    ),
    GetPage(
      name: '/mailCheckSuccessPage',
      page: () => MailCheckSuccessPage(),
    ),
  ];
}