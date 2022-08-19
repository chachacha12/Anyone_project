import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



//캐러셀슬라이더위젯(이미지 스와이핑)의 옵션값에 넣어야할 이미지리스트를 반환하는 메소드
Make_imagesliders(imgList){
  List<Widget> imageSliders = imgList //이미지리스트를 넣어줌
      .map<Widget>((item) =>
      Container( //item하나하나가 string으로된 사진주소 문자열 하나임.
        child: Container(
          margin: EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack( //위젯들을 겹치게 배치가능. 여기선 이미지위젯과 텍스트위젯을 겹치게 배치
                children: <Widget>[
                  Image.network(item, fit: BoxFit.cover, width: 1000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(

                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: Text( //슬라이드이미지들 밑에 뜰 텍스트
                        '', //No. ${imgList.indexOf(item)} image
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 10.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ))
      .toList();

  return imageSliders;
}


//RichText위젯을 반환해주는 메소드 - 여러스타일 문자를 하나의 Text위젯에 넣을때 사용
richtext(icon, text2){

  return RichText(
    text: TextSpan(
      children: [
        WidgetSpan(
          child: Container(
              margin: EdgeInsets.fromLTRB(0.w, 0.w, 0.w, 0.w),
              child: icon
          ),
        ),
        TextSpan(
          text: text2,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 15.sp,
            letterSpacing: -0.1.w,
          ),
        ),
      ],
    ),
  );
}
