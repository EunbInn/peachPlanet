import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:peach_planet_test/src/theme_values/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    var duration = Duration(seconds: 2);

    //2초 후 login page로 이동
    Future.delayed(duration, () {
      Get.offAndToNamed("/login");
    });
  }

  Future<bool> _checkAccessToken() async {
    var token = await AccessTokenStore.instance.fromStore();
    debugPrint(token.toString());
    if (token.refreshToken == null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.mainColor,
      body: Container(
        padding: EdgeInsets.only(bottom: 80),
        child: Center(
          child: Hero(
            tag: 'splash image',
            child: Container(
                child: SvgPicture.asset('images/IMG_Splash.svg')),
          ),
        ),
      ),
    );
  }
}