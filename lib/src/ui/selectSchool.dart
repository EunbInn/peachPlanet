import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:peach_planet_test/src/theme_values/colors.dart';

class SelectSchoolPage extends StatefulWidget {
  _SelectSchoolPageState createState() => _SelectSchoolPageState();
}

class _SelectSchoolPageState extends State<SelectSchoolPage> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";
  final List<String> storedStrings = ["naver", "nanana", "anna", "inna" , "daum", "kakao"];


  _SelectSchoolPageState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }
  List<String> _selected = [];
  String selectedResult = "";

  @override
  Widget buildList(String selected) {
    final isSelected = _selected.contains(selected);
    return ListTile(
      title: Text(
        _searchText.isEmpty
            ? ""
            : selected,
        style: TextStyle(
          fontFamily: 'NanumSquareRound',
          color: Colors.black38,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
      trailing: Icon(   // NEW from here...
        isSelected ? Icons.check_rounded : null,
      ),

      onTap: () {
        setState(() {
          if (_selected.contains(selected)) {
            _selected.remove(selected);
          } else {
            _selected.removeWhere((element) => !element.contains(selected));
            _selected.add(selected);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> suggestionList = [];
    for (String str in storedStrings) {
      if (str.contains(_searchText)) {
        suggestionList.add(str);
      }
    }
    return Scaffold(
        backgroundColor: ConstColor.mainColor,
        body: Container(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(10, 60, 10, 10),
                child: Text(
                  "어떤 학교에서 오셨어요?",
                  style: TextStyle(
                    fontFamily: 'NanumSquareRound',
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                  child: TextField(
                    controller: _filter,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                          left: 107, right: 100, top: 20, bottom: 20),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintText: ' 대학교 찾기',
                      hintStyle: TextStyle(
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
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.6,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListView.builder(
                  itemCount: suggestionList.length,
                  itemBuilder: (context, index) {
                    return buildList(suggestionList[index]);
                  },
                ),
              ),
              InkWell(
                onTap: () => Get.toNamed("/mailCheckPage", arguments: "naver"),
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: ConstColor.cursorPink,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '계속하기',
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
