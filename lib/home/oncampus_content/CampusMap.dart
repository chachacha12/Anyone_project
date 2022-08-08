import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class CampusMap extends StatelessWidget {
  const CampusMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            'Campus Map',
          ),
          ),

          //contactus와 애니원메일버튼, schoolcontact. 즉 3개 박스 들어감
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Finding your way'"\n"'around campus', style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp
                  )),
                  Text("\n"' - Konkuk University uses a numbering system to easily identify the various buildings on campus.'
                      "\n\n"' - Please refer to the graph below to see where your classes are held.'"\n", style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15.sp
                  )),

                  //이미지 1
                  Container(
                    width: 400.w,
                    height: 200.h,
                    child:  PhotoView(      //이미지를 줌인줌아웃 해주는 패키지로 만든 위젯
                      imageProvider: AssetImage("assets/Campusmap/campusmap_number.png"), //
                      initialScale: PhotoViewComputedScale.covered,
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  //이미지 2
                  Container(
                    width: 400.w,
                    height:400.h,
                    child:  PhotoView(      //이미지를 줌인줌아웃 해주는 패키지로 만든 위젯
                      imageProvider: AssetImage("assets/Campusmap/campusmap.jpeg"), //
                      initialScale: PhotoViewComputedScale.covered,
                    ),
                  ),

                  Text("\n"'Facilites', style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp
                  )),

                  SizedBox(
                    height: 10.h,
                  ),

                  //이미지 3
                  Container(
                    width: 400.w,
                    height: 400.h,
                    child:  PhotoView(      //이미지를 줌인줌아웃 해주는 패키지로 만든 위젯
                      imageProvider: AssetImage("assets/Campusmap/Facilities_aroundcampus_dining.png"), //
                      initialScale: PhotoViewComputedScale.covered,
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  //이미지 4
                  Container(
                    width: 400.w,
                    height: 400.w,
                    child:  PhotoView(      //이미지를 줌인줌아웃 해주는 패키지로 만든 위젯
                      imageProvider: AssetImage("assets/Campusmap/Facilities_aroundcampus_others.png"), //
                      initialScale: PhotoViewComputedScale.covered,
                    ),
                  ),

                  SizedBox(
                    height: 40.h,
                  ),


                ],
              ),
            ),
          ),






        ],
      ),
    );
  }
}
