import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

// Import kakao sdk
import 'package:kakao_flutter_sdk/auth.dart';
import 'package:kakao_flutter_sdk/user.dart';
import 'package:kakao_flutter_sdk/common.dart';

class ControllerLoginWithKakao extends GetxController {
  bool _isKakaoTalkInstalled = true;

  ControllerLoginWithKakao() {
    _initKakaoTalkInstalled();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('Kakao Install : ' + installed.toString());
    _isKakaoTalkInstalled = installed;
  }


  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      Get.toNamed('/mainPage');
    } catch (e) {
      print("error on issuing access token: $e");
    }
  }

  _loginWithKakao() async {
    try{
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print('error on login: $e');
    }
    // return (await AccessTokenStore.instance.fromStore()).accessToken;
  }

  _loginWithTalk() async {
    try{
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print('error on login: $e');
    }
    // return (await AccessTokenStore.instance.fromStore()).accessToken;
  }

  loginWithKakaoAccount() async {
    try {
      var provider = 'kakao';
      var token = _isKakaoTalkInstalled ? _loginWithTalk() : _loginWithKakao();

      // 회원가입 여부를 판단함
      print("access_token: $token");

      Get.toNamed("/selectSchool");
    } catch (e) {
      print('error on login: $e');
    }
  }
}