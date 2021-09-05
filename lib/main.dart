import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:kakao_flutter_sdk/common.dart'; // import utility methods
import 'package:kakao_flutter_sdk/user.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:peach_planet_test/src/theme_values/colors.dart';
import 'package:peach_planet_test/src/ui/splashPage.dart';
import 'package:get/get.dart';
import 'package:peach_planet_test/src/app_pages.dart';

//not used yet

void main() {
  KakaoContext.clientId = "24e9cbba7a31ab4201c2c104b2fa30e8";
  KakaoContext.javascriptClientId = "26d550c3979c491acce129e8eea0f625";
  runApp(GetMaterialApp(
    home: SplashPage(),
    getPages: AppPages.pages,
    defaultTransition: Transition.fadeIn,
    theme: ThemeData(
      primaryColor: ConstColor.mainColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    )
  );
}

