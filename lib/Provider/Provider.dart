import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///state 보관하는 클래스
class Store1 extends ChangeNotifier{

  //시간표의 수업요소들 색깔 15가지
  var colorList = [
    Colors.redAccent, Colors.deepPurpleAccent, Colors.green, Colors.amberAccent, Colors.greenAccent,
    Colors.cyan, Colors.deepOrangeAccent, Colors.brown, Colors.pink, Colors.grey,
    Colors.blue, Colors.blueGrey, Colors.purpleAccent, Colors.yellowAccent, Colors.lime
  ];

  //각각의 수업일정들 map을 리스트안에 저장 - null도 저장할 수 있도록 허용하고 15개를 미리 null 초기화함,growable: true를 해서 크기 변할수있음
  List<Map ?> unCompleteMeetings =List.filled(15, null, growable: true);
  //수업추가해주는 함수
  addMeetingsData(map){
    unCompleteMeetings.add(map);
    notifyListeners();
  }

  //원하는 index안에 수업추가해주는 함수
  addIndexMeetingsData(index, map){
    unCompleteMeetings.insert(index, map);
    notifyListeners();
  }

  //수업삭제해주는 함수
  deleteMeetingsData(index){
    //unCompleteMeetings.removeAt(index);
    unCompleteMeetings[index] = null;  //다시 null을 채워줌
    print('index:'+index.toString()+'인 것 삭제하고 그 자리에 null값 다시 넣어줌');
    notifyListeners();
    print('unCompleteMeetings: '+unCompleteMeetings.toString());
  }

  //sharedpref에서 가져온 유저이름 저장
  var username;
  ChangeUserName(i){
    username = i;
    notifyListeners();
  }

  var tab =0;  //바텀바에서 유저가 누를때 페이지전환 시켜주기위한 state
  //tab값 변경함수
  ChangeTab(i){
    tab = i;
    notifyListeners();
  }

  //my.dart에서 보여줄 출국날짜값
  var departure_date = 'Pick';
  ChangeDepartureDate(i){
    departure_date = i;
    notifyListeners();
  }

  //my.dart에서 보여줄 d-day값
  var dday = '- 000';
  ChangeDday(i){
    dday = i;
    notifyListeners();
  }

  //my.dart에서 보여줄 한국도착날짜값
  var arrival_date = 'Pick';
  ChangeArrivalDate(i){
    arrival_date = i;
    notifyListeners();
  }

  //my.dart에서 보여줄 그래프 퍼센트값
  var percent = 0.0;
  ChangePercent(i){
    percent = i;
    notifyListeners();
  }
}