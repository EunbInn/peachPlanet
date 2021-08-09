import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:kakao_flutter_sdk/common.dart'; // import utility methods
import 'package:kakao_flutter_sdk/user.dart';
import 'package:kakao_flutter_sdk/auth.dart';
import 'constValue.dart';

//not used yet
class Route {
  static const INITIAL = '/';
  static const LOGIN = '/login';
}
void main() {
  KakaoContext.clientId = "24e9cbba7a31ab4201c2c104b2fa30e8";
  KakaoContext.javascriptClientId = "26d550c3979c491acce129e8eea0f625";
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
  // bool isLogin = false;

  @override
  void dispose() {
    super.dispose();
  }

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
      Navigator.push(context, MaterialPageRoute(
          builder: (context) => LoginDone()
      ),);
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
  }

  _loginWithTalk() async {
    try{
      var code = await AuthCodeClient.instance.requestWithTalk();
      await _issueAccessToken(code);
    } catch (e) {
      print('error on login: $e');
    }
  }

  logOutTalk() async {
    try {
      var code = await UserApi.instance.logout();
      print(code.toString());
    } catch (e) {
      print('error on logout: $e');
    }
  }

  unlinkTalk() async {
    try {
      var code = await UserApi.instance.unlink();
      print(code.toString());
    } catch (e) {
      print('error on logout: $e');
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
            Padding(padding: EdgeInsets.only(top: 90, bottom: 80),
              child: Container(
                child: SvgPicture.asset('images/IMG_Splash.svg'),
              ),
            ),
            //kakao talk login----------------------------------------------------
            InkWell(
              onTap: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
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
            InkWell(
              onTap: _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
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

//logout not yet
class LoginDone extends StatelessWidget {

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


