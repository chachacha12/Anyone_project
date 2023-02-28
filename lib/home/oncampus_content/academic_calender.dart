import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

import 'asset_hero_image.dart';

//academic calender를 보려고 클릭시 띄워줄 커스텀 위젯.  이미지 2개 보여줄거임
class Calender extends StatelessWidget {
   Calender({Key? key}) : super(key: key);

  var ImageList =[
    'assets/academic_calender/Calender_version_1.png',
    'assets/academic_calender/Calender_version_2.png'
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  //collapsedHeight: 50.h,
                  title: Text('Academic Calender'),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Official Ver',),
                      Tab(text: 'OIA Ver',)
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
            body: Container(
              color: Colors.white,
              child: TabBarView(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(5.w),
                      child:  GestureDetector(   //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                        child: Hero(
                          tag: ImageList[0],
                          child: Image.asset(ImageList[0],
                            fit: BoxFit.fill,),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  Asset_hero_image(ImageList[0])  ));
                        },
                      ),
                  ),
                  Container(
                    color: Colors.white,
                      margin: EdgeInsets.all(5.w),
                      child:  GestureDetector(   //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                        child: Hero(
                          tag: ImageList[0],
                          child: Image.asset(ImageList[1]
                            ,
                            fit: BoxFit.fill,),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  Asset_hero_image(ImageList[1])  ));
                        },
                      ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
