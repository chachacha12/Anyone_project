import 'package:anyone/home/aroundcampus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'oncampus.dart';

//on-campus, around-campus 아이콘들을 스와이프 하면서 보여주는 첫 페이지
class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}


class _InfoState extends State<Info>  {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                 SliverAppBar(
                   automaticallyImplyLeading: false, ///자동으로 생기는 뒤로가기 키 삭제
                   toolbarHeight:25.h,
                   backgroundColor: Color(0xff73c088),
                   leadingWidth: 90.w,
                   leading: Image.asset('assets/appBar.png', fit: BoxFit.contain ,width: 40.w),
                  // title:   Text('Anyone', style: TextStyle(color: Colors.black)),
                   pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: '    ON'+'\n'+'campus',),
                      Tab(text: '    OFF'+'\n'+'campus',)
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 0.1,
                    indicatorColor: Color(0xff73c088),
                    unselectedLabelColor: Color(0xff397D54),
                    labelColor: Colors.white,
                    unselectedLabelStyle: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500,
                        fontFamily:'roboto'),
                    labelStyle: TextStyle(
                        fontSize:14.sp, fontWeight: FontWeight.w500, fontFamily:'roboto'),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                OnCampus(), AroundCampus(),
              ],
            ),
          )),
    );
  }
}

