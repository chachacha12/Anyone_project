import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


///찜목록 관련 state들을 저장해주는 store
class MyListStore extends ChangeNotifier{

  ///main에서 현재 접속한 유저의 찜목록 컬렉션들을 전부 가져옴. 그후 컬렉션별로 저장해줌

  /// 1.엔터 컬렉션
  var entertainmentMyList;  //엔터 컨텐츠 내 찜목록 문서들 리스트임
  getEnterMyListCollection(collection){ // main에서 이 함수 실행해서 문서들 리스트 저장해줌
    entertainmentMyList = collection;
    notifyListeners();
  }
  addEntertainment(doc){
    entertainmentMyList.add(doc);
    print('provider에서 추가');
    notifyListeners();
    print('entertainmentMyList:'+ entertainmentMyList.toString());
  }
  deleteEntertainment(doc){
    entertainmentMyList.remove(doc);
    print('provider에서 삭제');
    notifyListeners();
    print('entertainmentMyList:'+ entertainmentMyList.toString());
  }

  ///2.패션 컬렉션
  var fashionMyList;
  getFashionMyListCollection(collection){ // main에서 이 함수 실행해서 문서들 리스트 저장해줌
    fashionMyList = collection;
    notifyListeners();
  }
  addFashion(doc){
    fashionMyList.add(doc);
    print('provider에서 추가');
    notifyListeners();
  }
  deleteFashion(doc){
    fashionMyList.remove(doc);
    print('provider에서 삭제');
    notifyListeners();
  }

  ///3.groceries 컬렉션
  var groceriesMyList;
  getGroceriesMyListCollection(collection){
    groceriesMyList = collection;
    notifyListeners();
  }
  addGroceries(doc){
    groceriesMyList.add(doc);
    print('provider에서 추가');
    notifyListeners();
  }
  deleteGroceries(doc){
    groceriesMyList.remove(doc);
    print('provider에서 삭제');
    notifyListeners();
  }

  ///4.식당 컬렉션
  var restaurantMyList;
  getRestaurantMyListCollection(collection){
    restaurantMyList = collection;
    notifyListeners();
  }
  addRestaurant(doc){
    restaurantMyList.add(doc);
    print('provider에서 추가');
    notifyListeners();
  }
  deleteRestaurant(doc){
    restaurantMyList.remove(doc);
    print('provider에서 삭제');
    notifyListeners();
  }

  ///5.카페 컬렉션
  var cafeMyList;
  getCafeMyListCollection(collection){
    cafeMyList = collection;
    notifyListeners();
  }
  addCafe(doc){
    cafeMyList.add(doc);
    print('provider에서 추가');
    notifyListeners();
  }
  deleteCafe(doc){
    cafeMyList.remove(doc);
    print('provider에서 삭제');
    notifyListeners();
  }


  ///6.펍 컬렉션
  var pubMyList;
  getPubMyListCollection(collection){
    pubMyList = collection;
    notifyListeners();
  }
  addPub(doc){
    pubMyList.add(doc);
    print('provider에서 추가');
    notifyListeners();
  }
  deletePub(doc){
    pubMyList.remove(doc);
    print('provider에서 삭제');
    notifyListeners();
  }

}


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