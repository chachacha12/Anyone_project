import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

//academic calender를 보려고 클릭시 띄워줄 커스텀 위젯.  이미지 2개 보여줄거임
class Calender extends StatelessWidget {
  const Calender({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  collapsedHeight: 50.h,

                  title: Text('Academic Calender'),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Version 1',),
                      Tab(text: 'Version 2',)
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 1,
                    indicatorColor: Colors.white,
                    unselectedLabelColor: Color(0xFFDDDDDD),
                    labelColor: Colors.white,
                    unselectedLabelStyle: TextStyle(color: Colors.pinkAccent, fontSize: 15.sp),
                    labelStyle: TextStyle(
                        color: Colors.amber, fontSize:23.sp, fontWeight: FontWeight.bold),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                Container(
                    child: PhotoView(      //이미지를 줌인줌아웃 해주는 패키지로 만든 위젯
                      imageProvider: AssetImage("assets/Calender_version_1.png"),
                    )
                ),
                Container(
                    child: PhotoView(
                      imageProvider: AssetImage("assets/Calender_version_2.png"),
                    )
                ),
              ],
            ),
          )),
    );
  }
}
