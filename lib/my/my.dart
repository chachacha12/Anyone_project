import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

//유저정보 보여주는 페이지
class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {

/* DatePicker 띄우기 */
  showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2022), //시작일
      lastDate: DateTime(2025), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {      //날짜 선택 직후에 할일
      //토스트메시지 띄우기
      Fluttertoast.showToast(
        msg: dateTime.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        //fontSize: 20,
        //textColor: Colors.white,
        //backgroundColor: Colors.redAccent
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          //SliverAppBar의 높이 설정
          toolbarHeight: 50.0.h,
          //SliverAppBar의 backgroundcolor
          backgroundColor: Colors.transparent,
          //하단 List를 최상단으로 올렸을때의 SliverAppBar의 Default height
          //expandedHeight를 사용하면 스크롤을 내리면 toolbarheight높이까지 줄어든다.
          expandedHeight: 0.0.h,
          //SliverAppBar의 그림자 정도
          elevation: 0.0,
          //SliverAppBar title
          title: Text("My Information", style: TextStyle(color: Colors.black),),
          //SliverAppBar 영역을 고정시킨다. default false
          pinned: true,
          // AppBar가 하단 List 내렸을 때 바로 보여야 한다 -> true
          // List를 최상단으로 올렸을 때만 나와야 한다. -> false
          floating: true,
        ),

        //이메일, 풀네임, 닉네임을 보여줌
        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            height: 150.0.h,
            child: Container(
              color: Colors.green,
              width: 200.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('E-mail:  '),
                      Text('12zxccha@'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Full Name:  '),
                      Text('chaminwoo')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Nickname:  '),
                      Text('chachacha')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            height: 300.h,
            width: 100.0.w,
            child: Container(
              alignment: Alignment.center,
              color: Colors.yellow,
              height: 300.0.h,
              width: 250.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('D - 000'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Departure Date:     '),
                      TextButton(onPressed: (){
                        showDatePickerPop();
                      }, child: Text('날짜 선택하기'))
                    ],
                  ),

                ],
              ),
              ),
          ),
        ),

      ],

    );
  }
}
