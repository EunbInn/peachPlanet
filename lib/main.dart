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
        primaryColor: mainColor,
        primaryIconTheme: Icon(SvgPicture.asset('images/peach_main.svg')),
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

  // @override
  // Widget image(BuildContext context) {
  //   return Scaffold (
  //     body: Center(
  //       )
  //     );
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: InkWell(
            onTap: () => _isKakaoTalkInstalled ? _loginWithTalk : _loginWithKakao,
            child:Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.yellow
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //Icons 카카오톡 아이콘 찾아서 넣기
                children: [Icon(Icons.chat_bubble_rounded, color: Colors.brown[800]),
                  SizedBox(width: 10,),
                  Text(
                    '카카오 계정으로 시작',
                    style: TextStyle(
                        color: Colors.brown[800],
                        fontWeight: FontWeight.w900,
                        fontSize: 18
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

  @override
  Widget MainImage(BuildContext context) {
    return Scaffold(
      body: Center(

      )
    );
  }
}



