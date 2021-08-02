import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:kakao_flutter_sdk/common.dart'; // import utility methods
import 'package:kakao_flutter_sdk/user.dart';
import 'constValue.dart';

class Route {
  static const INITIAL = '/';
  static const LOGIN = '/login';
}
void main() {
  KakaoContext.clientId = "2842cdeca515e53a5d1e7f1fdf72f23a";
  KakaoContext.javascriptClientId = "080ef3c31fd3f162f8e3ddd5ef311260";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: ConstColor.mainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: KakaoLogin(),
    );
  }
}

class KakaoLogin extends StatefulWidget {
  @override
  _KakaoLoginState createState() => _KakaoLoginState();
}

class _KakaoLoginState extends State<KakaoLogin> {
  bool _isKakaoTalkInstalled = false;
  bool isLogin = false;

  @override
  void initState() {
    _initKakaoTalkInstalled();
    super.initState();
  }

  _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print('Kakao Install : ' + installed.toString());
    //카카오톡 인스톨 여부에 따라 web연결 혹은 app 연결

    setState(() {
      _isKakaoTalkInstalled = installed;
    });

  }

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      print('token : ' + token.accessToken);
      setState(() {
        isLogin = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  _loginWithKakao() async {
    try{
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e.toString());
    }
  }

  _loginWithTalk() async {
    try{
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build..
    return Scaffold(
      backgroundColor: ConstColor.mainColor,
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 120, bottom: 80),
              child: Container(
                child: SvgPicture.asset('images/IMG_Splash.svg'),
              ),
            ),
            //kakao talk login----------------------------------------------------
            InkWell(
              onTap:() => _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
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
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding (padding: EdgeInsets.only(bottom: 13)),
            //apple login(method build not yet)--------------------------------------------------------
            InkWell(
              onTap:() => _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
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
                          fontSize: 18,
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



