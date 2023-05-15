import 'package:anyone/Provider/ProviderManager.dart';
import 'package:anyone/Style.dart' as style;
import 'package:anyone/splash/SplashScreen.dart';
import 'package:anyone/timetable/Timetable.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Provider/Provider.dart';
import 'home/info.dart';
import 'keeping/Keep.dart';
import 'my/my.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';



void main() async {

  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //상태표시줄 색깔 변경해줌
  SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle( statusBarColor: Colors.transparent));

  WidgetsFlutterBinding.ensureInitialized();  //가로모드로 변경때 반응형사이즈에 에러생기는거 방지용. 회전을 방지.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      MultiProvider(providers: [ //store를 여러개 등록해둘 수 있음
        ChangeNotifierProvider(create: (c) => Store1()),
        ChangeNotifierProvider(create: (c) => Store1()),
      ],
          child: ScreenUtilInit( //화면 반응형앱을 위한 패키지로 만든 위젯
            designSize: Size(360, 690),
            builder: (BuildContext context, Widget? child) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: style.theme, //Style.dart에 따로 빼둔 변수값을 가져와서 디자인에 씀
                  home: MyApp()
              );
            },

          )
      ));
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Splash();
  }
}


//로그인해서 들어왔을때 처음 메인화면임. 정보공유와 내정보 탭 둘다 볼 수 있는곳
class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {

  //스낵바 띄우기
  ShowSnackBar(text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text), // 필수!
        // Icon 위젯도 가능해용
        duration: Duration(seconds: 3), // 얼마큼 띄울지
        // Duration 으로 시간을 정할 수 있어요
        backgroundColor: Colors.green, // 색상 지정
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    /// Provider관리하는 클래스객체 하나를 생성, 파베에서 몇몇 데이터 가져와서 provider에 저장
    var pm = ProviderManager();
    pm.getData();
  }

  //하단 네비케이션바에 필요한 키인듯
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //원래 기존 평범한 바텀바임
      body:
        IndexedStack(
          index: context.watch<Store1>().tab,
          children: [
            Info(),Timetable(), Keep(), My()
          ],
        ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<Store1>().tab,
        showSelectedLabels: false,
        showUnselectedLabels:false,
        iconSize: 25.sp,
        selectedIconTheme: IconThemeData(
            color: Colors.green
        ),
        unselectedIconTheme: IconThemeData(
            color: Colors.grey
        ),
        elevation: 2,
        backgroundColor: Colors.white,
        //selectedFontSize: 14, //선택된 아이템의 폰트사이즈
        //unselectedFontSize: 14, //선택 안된 아이템의 폰트사이즈
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: ' Info'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: ' Timetable'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: ' Keep'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded), label: ' My'),
        ],
        onTap: (i){    //i는 바텀네비게이션에서 누르는 버튼 순서번호임. 첫번째 버튼 누르면 i는 0이됨.
          setState(() => context.read<Store1>().ChangeTab(i));
        },
      ),
    );

  }
}


