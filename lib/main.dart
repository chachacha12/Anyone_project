import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home/info.dart';
import 'my/my.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'authentic/login.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( 
      MultiProvider(providers: [        //store를 여러개 등록해둘 수 있음
        ChangeNotifierProvider(create: (c) => Store1()),
        ChangeNotifierProvider(create: (c) =>  Store1()),
      ],
        child:  ScreenUtilInit(   //화면 반응형앱을 위한 패키지로 만든 위젯
            designSize: Size(360,690),
          builder: (BuildContext context, Widget? child) {
              return  MaterialApp( home: MyApp());
          },

        )
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

  //my.dart에서 보여줄 출국날짜값
  var date = '날짜선택하기';
  ChangeDate(i){
    date = i;
    notifyListeners();
  }

  //my.dart에서 보여줄 d-day값
  var dday = '- 000';
  ChangeDday(i){
    dday = i;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Main();
    //return authentic();
  }
}


//로그인해서 들어왔을때 처음 메인화면임. 정보공유와 내정보 탭 둘다 볼 수 있는곳
class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
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


