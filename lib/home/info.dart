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
                   backgroundColor: Color(0xff17F597),

                  title: Text('Anyone', style: TextStyle(color: Colors.black)),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: '    on'+'\n'+'campus',),
                      Tab(text: '    off'+'\n'+'campus',)
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 2,
                    indicatorColor: Colors.greenAccent,
                    unselectedLabelColor: Colors.black,
                    labelColor: Colors.white,
                    unselectedLabelStyle: TextStyle(fontSize: 12.sp),
                    labelStyle: TextStyle(
                        fontSize:16.sp, fontWeight: FontWeight.w500),
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

