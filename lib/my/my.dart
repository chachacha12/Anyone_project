import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//유저정보 보여주는 페이지
class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
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
            color: Colors.pinkAccent,
            alignment: Alignment.center,
            height: 150.w,
            width: 100.0.w,
            child: Container(
              color: Colors.yellow,
              height: 150.0.w,
              width: 40.w,
              child: Text('aa'),
              ),
          ),
        )

      ],

    );
  }
}