import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:peach_planet_test/src/controller/controller_loginWithKakao.dart';
import 'package:peach_planet_test/src/theme_values/colors.dart';

class LoginPage extends StatelessWidget {
  final ControllerLoginWithKakao _controllerLoginWithKakao = Get.put(ControllerLoginWithKakao());
  //애플 로그인 만들면 바꿔주기
  final _controllerLoginWithApple = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.mainColor,
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 50, bottom: 80),
              child: Container(
                child: SvgPicture.asset('images/IMG_Splash.svg'),
              ),
            ),
            //kakao talk login----------------------------------------------------
            TextButton(
              onPressed: () => _controllerLoginWithKakao.loginWithKakaoAccount(),
              child:Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: ConstColor.kakaoColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('images/ic_logo_kakao.svg'),
                    SizedBox(width: 20,),
                    Text(
                      '카카오 계정으로 시작',
                      style: TextStyle(
                        fontFamily: 'NanumSquareRound',
                        color: Colors.brown[900],
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding (padding: EdgeInsets.only(bottom: 10)),
            //apple login(apple login method build not yet)--------------------------------------------
            TextButton(
              onPressed: _controllerLoginWithApple,
              child:Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.09,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [SvgPicture.asset('images/ic_logo_apple.svg'),
                    SizedBox(width: 32,),
                    Text(
                      '애플 계정으로 시작',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        fontFamily: 'NanumSquareRound',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}