import 'dart:async';
import 'package:anyone/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentic/login.dart';
import 'package:simple_animations/simple_animations.dart';

//젤 처음 실행되는 스플래쉬화면임. 여기서 자동로그인 여부 확인후 메인화면갈지 로그인화면 갈지 정함
class Splash extends StatefulWidget {
   Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  String? name;
  late bool auto_signin;

  //shared pref에 저장된 유저정보있는지보고 없으면 회원가입창으로 이동
  Is_SignIn_before() async {
    var storage = await SharedPreferences.getInstance();
    //storage.remove('name');
    //storage.remove('email');
    name = storage.getString('name');
    //store에 있는 state를 변경해주는 메소드
    //context.read<Store1>().ChangeUserName(name);

    print(name);

    //만약 sharedpref에 유저이름정보 없으면 로그인화면으로감
    if(name ==null){   //sharedpref에 유저이름이 저장된값이 없다면
      auto_signin = false;
    }else{    //저장된값있으면 자동 로그인
      auto_signin = true;
      context.read<Store1>().ChangeUserName(name);  //provider에 있는 state에게 이름값전달
    }
  }


  @override
  void initState() {
    super.initState();

    Is_SignIn_before(); //기존에 로그인한적있어서 자동로그인 할지말지 결정

    //1.5초뒤에 자동로그인 여부에 따라 메인화면으로 갈지 회원가입창으로 갈지 정함
    Timer(Duration(milliseconds: 1800), () {
      if (auto_signin) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => Main()
        )
        );

        Fluttertoast.showToast(
          msg: 'Hello, $name !',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          //fontSize: 20,
          //textColor: Colors.white,
          //backgroundColor: Colors.redAccent
        );

      } else {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) =>
                authentic()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    const String imageLogoName = 'assets/android_icon.png';
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor:1.0),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            //height : MediaQuery.of(context).size.height,
            //color: kPrimaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.394375),

/*
  //애니메이션 위젯 - 패키지 설치한후 사용가능
            PlayAnimationBuilder<double>(
              tween: Tween(begin: 50.0, end: 200.0),
              duration: const Duration(seconds: 5),
              child: const Center(child: Text('Hello!')), // pass in static child
              builder: (context, value, child) {
                return Container(
                  width: value,
                  height: value,
                  color: Colors.green,
                  child: Image.asset(
                    imageLogoName,
                    width: screenWidth * 0.616666,
                    height: screenHeight * 0.0859375,
                  ), // use child inside the animation
                );
              },
            ),
 */


/*

               //Expanded(child: SizedBox()),
                Align(
                  child: Text("Anyone can enjoy\nCampus life",
                      style: TextStyle(
                        fontSize: screenWidth*( 20/360), color: Colors.greenAccent,)
                  ),
                ),
 */
                //SizedBox( height: 20.h),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 60.r,
                  child: Image.asset(
                    imageLogoName,
                    width: screenWidth * 0.616666,
                    height: screenHeight * 0.0859375,
                  ),
                ),

                //Expanded(child: SizedBox()),
                SizedBox( height: 20.h),
                Align(
                  child: LoopAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.5),
                    duration: const Duration(seconds: 3),
                    curve: Curves.decelerate,
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: Text("Anyone can enjoy\nCampus life",
                        style: TextStyle(color: Colors.green,
                            fontSize: screenWidth*( 20/360))
                    ),
                  ),
                ),

                SizedBox( height: MediaQuery.of(context).size.height*0.0625,),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
