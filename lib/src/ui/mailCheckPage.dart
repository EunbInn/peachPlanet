import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:peach_planet_test/src/theme_values/colors.dart';

class MailCheckPage extends StatefulWidget {
  _MailCheckPageState createState() => _MailCheckPageState();
}

class _MailCheckPageState extends State<MailCheckPage> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _inputText = "";
  var value = Get.arguments;
  String email = "";

  sendEmail(String subject, String body, String recipients) async {
    final Email emailSend = Email(
        body: body, subject: subject, recipients: [recipients], isHTML: false);
    String platformResponse;

    await FlutterEmailSender.send(emailSend);
    platformResponse = 'success';

    print(platformResponse);

    Get.toNamed("/mailCheckSuccessPage");
  }

  @override
  Widget build(BuildContext context) {
    if (value == "naver") {
      email = "@naver.com";
    }

    _filter.addListener(() {
      setState(() {
        _inputText = _filter.text;
      });
    });
    return Scaffold(
        backgroundColor: ConstColor.mainColor,
        body: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
                child: Text(
                  value + "계정으로\n 이메일 인증 해주세요",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'NanumSquareRound',
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: TextField(
                    controller: _filter,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 30, right: 55, top: 20, bottom: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      suffixText: email,
                      suffixStyle: TextStyle(
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                      fillColor: Color.fromRGBO(255, 255, 255, 0.3),
                      filled: true,
                    ),
                    cursorColor: ConstColor.cursorPink,
                    cursorWidth: 2,
                    cursorRadius: Radius.circular(10),
                  )),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  "학교 다시 선택",
                  style: TextStyle(
                    color: ConstColor.cursorPink,
                    fontFamily: 'NanumSquareRound',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Get.toNamed("/mailCheckSuccessPage"),
                    // sendEmail("Test title", "Test body", "dsino@naver.com"),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: _inputText.isEmpty
                        ? Colors.black12
                        : ConstColor.cursorPink,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '메일보내기',
                        style: TextStyle(
                          fontFamily: 'NanumSquareRound',
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
