import 'package:anyone/home/aroundcampus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'oncampus.dart';
import 'aroundcampus.dart';

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

                  title: Text('Anyone'),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'On-Campus',),
                      Tab(text: 'Around-Campus',)
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 2,
                    indicatorColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                    labelStyle: TextStyle(
                        fontSize:18.sp, fontWeight: FontWeight.w500),
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

