import 'package:anyone/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../authentic/login.dart';

///이미지들 저장하는 리스트
final List<String> imgList = [
  'assets/AppExplain/appExplain1.png',
  'assets/AppExplain/appExplain2.png',
  'assets/AppExplain/appExplain5.png',
];

///문구들 저장하는 리스트
final List<String> textList = [
  'Find out useful On-campus information at once.',  //온캠퍼스
  'Look around the local places around the school recommended by students.', //오프캠퍼스
  'Check your class schedule easily and quickly.', //시간표
  'Save the places you want to go and visit there anytime.', //찜페이지
  'Check the D-Day left until the departure.', // 디데이 기능
];

class AppExplain extends StatefulWidget {
  const AppExplain({Key? key}) : super(key: key);

  @override
  State<AppExplain> createState() => _AppExplainState();
}

class _AppExplainState extends State<AppExplain> {

  int currentIndex =0; //캐러셀 사진 슬라이더에 indicator를 달아주기위한 변수
  CarouselController buttonCarouselController = CarouselController();
  bool isLastIndex = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20.h,
        elevation: 0,
      ),
      body: Container(
        color:Colors.white,
        child: Column(  ///캐러셀 슬라이드와 indicator 들어감
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ///이미지와 문구를 감싸는 박스
            Container(
              padding:  EdgeInsets.fromLTRB(0.h,10.h, 0.h, 20.h),
              alignment: Alignment.topCenter,
              //color: Colors.red,
              child: Column(  ///이미지와 문구를 배열시킴
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ///이미지
                  CarouselSlider( //이미지슬라이드 해주는 위젯
                    carouselController: buttonCarouselController,  ///슬라이드를 컨트롤해주는 객체. 버튼으로 페이지 넘기기 가능
                    options: CarouselOptions(
                        initialPage: 0,
                        reverse: false,
                        height: 400.h,
                        viewportFraction: 0.9,
                        aspectRatio: 1,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason){
                          setState((){
                            currentIndex = index;
                            print('currentIndex: '+currentIndex.toString());

                            ///만약 현재 인덱스값이 마지막 페이지 인덱스라면 시작하기 버튼을 보여줄거임
                            if(currentIndex == imgList.length-1){
                              isLastIndex = true;
                            }else{
                              isLastIndex = false;
                            }
                          });
                        }
                    ),
                    items:  imgList
                        .map((item) => Center(
                        child:
                        Image.asset(item, fit: BoxFit.cover ,width: 230.w,)))
                        .toList(),
                  ),
                  ///문구
                  Text(textList[currentIndex], textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold
                  )
                    ,),
                ],
              )
            ),

            ///점들
            DotsIndicator(
              dotsCount: imgList.length,
              position: currentIndex.toDouble(),
              decorator: DotsDecorator(
                color: Colors.grey,  // Inactive color
                activeColor: Color(0xff73c088),
                size: const Size.square(6.0),
                activeSize: const Size(7.0, 7.0),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(0.h,20.h, 0.h, 0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ///이전버튼
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(	//모서리를 둥글게,
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xff397D54), width: 1)),
                        primary: Colors.white,
                        onPrimary: Color(0xff397D54),	//글자색
                        minimumSize: Size(80.w, 40.h),	//width, height
                        //child 정렬 - 아래의 Text('$test')
                        alignment: Alignment.center,
                    ),
                    child: Text('pre', textAlign: TextAlign.center,style: TextStyle(
                      fontSize: 15.sp
                    ),),
                    onPressed: () {
                      buttonCarouselController.previousPage(
                          duration: Duration(milliseconds: 300), curve: Curves.linear);
                    },
                  ),

                  ///다음버튼 - 만약 마지막 페이지라면 시작하기 버튼을 보여줄거임
                  isLastIndex ? ElevatedButton(  ///시작하기 버튼
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(	//모서리를 둥글게
                          borderRadius: BorderRadius.circular(10)),
                      primary: Colors.red,
                      onPrimary: Colors.white,	//글자색
                      minimumSize: Size(80.w, 40.h),	//width, height
                      //child 정렬 - 아래의 Text('$test')
                      alignment: Alignment.center,
                    ),
                    child: Text('start', textAlign: TextAlign.center,style: TextStyle(
                        fontSize: 16.sp
                    ),),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              authentic()));
                    },
                  ) :
                  ElevatedButton(  /// next 버튼
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(	//모서리를 둥글게
                          borderRadius: BorderRadius.circular(10)),
                      primary: Color(0xff397D54),
                      onPrimary: Colors.white,	//글자색
                      minimumSize: Size(80.w, 40.h),	//width, height
                      //child 정렬 - 아래의 Text('$test')
                      alignment: Alignment.center,
                    ),
                    child: Text('next', textAlign: TextAlign.center,style: TextStyle(
                        fontSize: 15.sp
                    ),),
                    onPressed: () {
                      buttonCarouselController.nextPage(
                          duration: Duration(milliseconds: 300), curve: Curves.linear);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
