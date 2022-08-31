import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//모든 아이콘, 텍스트, 앱바 등에 전역으로 스타일주는 녀석.
//메인 코드 길어지는거 방지용으로 따로 파일로 빼두고 변수 만들어서 사용
var theme = ThemeData(
    ///앱바스타일
    appBarTheme: AppBarTheme(
        elevation: 1,
        centerTitle: true,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
        ),
        color: Colors.white,
        //뒤로가기버튼의 색상
        iconTheme: IconThemeData(
          color: Colors.black
        )
        //actionsIconTheme: IconThemeData(color: Colors.white)
    ),

    ///글자스타일
    textTheme: TextTheme(
        bodyText2: TextStyle(
            color: Colors.black,
          fontWeight: FontWeight.w600,
        )
    ),
    textButtonTheme: TextButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: TextStyle(
            color: Colors.black
          )),
    ),



);