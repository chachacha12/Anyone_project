import 'package:anyone/Style.dart' as style;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'home/info.dart';
import 'my/my.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'authentic/login.dart';
import 'package:shared_preferences/shared_preferences.dart';



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
              return  MaterialApp(
                  theme: style.theme, //Style.dart에 따로 빼둔 변수값을 가져와서 디자인에 씀
                  home: MyApp());
          },

        )
      ));
}

//state 보관하는 클래스
class Store1 extends ChangeNotifier{

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
  var date = 'Pick';
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

  //shared pref에 저장된 유저정보있는지보고 없으면 회원가입창으로 이동
  getData() async {
    var storage = await SharedPreferences.getInstance();
    String? name = storage.getString('name');
    //store에 있는 state를 변경해주는 메소드
    context.read<Store1>().ChangeUserName(name);

    //만약 sharedpref에 유저이름정보 없으면 로그인화면으로감
    if(name ==null){   //sharedpref에 유저이름이 저장된값이 없다면
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
          authentic() ));
    }else{    //저장된값있으면 자동 로그인
      Fluttertoast.showToast(
        msg: 'Hello, $name !',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //fontSize: 20,
        //textColor: Colors.white,
        //backgroundColor: Colors.redAccent
      );
    }
  }

  //스낵바 띄우기
  ShowSnackBar(text){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text), // 필수!
        // Icon 위젯도 가능해용
        duration: Duration(seconds: 3), // 얼마큼 띄울지
        // Duration 으로 시간을 정할 수 있어요
        backgroundColor: Colors.blue, // 색상 지정
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //리스트안에 페이지들을 넣어서 유저가 바텀탭 누를때마다 각각을 붙여줌
      body: [
        Info(), My()
      ][context.watch<Store1>().tab],  //Store1안의 state를 가져옴

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
        elevation: 0,
        //selectedFontSize: 14, //선택된 아이템의 폰트사이즈
        //unselectedFontSize: 14, //선택 안된 아이템의 폰트사이즈
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: ' Info'),
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


