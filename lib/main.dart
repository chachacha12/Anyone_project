import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/info.dart';
import 'my/my.dart';

void main() {
  runApp( 
      MultiProvider(providers: [        //store를 여러개 등록해둘 수 있음
        ChangeNotifierProvider(create: (c) => Store1()),
        ChangeNotifierProvider(create: (c) =>  Store1()),
      ],
        child: MaterialApp(home: MyApp()),
      ));
}

//state 보관하는 클래스
class Store1 extends ChangeNotifier{
  var tab =0;  //바텀바에서 유저가 누를때 페이지전환 시켜주기위한 state
  //tab값 변경함수
  ChangeTab(i){
    tab = i;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //리스트안에 페이지들을 넣어서 유저가 바텀탭 누를때마다 각각을 붙여줌
      body: [
        Info(), My()
      ][context.watch<Store1>().tab],  //Store1안의 state를 가져옴

      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: ' Info'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: ' My'),
        ],
        onTap: (i){    //i는 바텀네비게이션에서 누르는 버튼 순서번호임. 첫번째 버튼 누르면 i는 0이됨.
          context.read<Store1>().ChangeTab(i);
        },
      ),
    );
  }
}

