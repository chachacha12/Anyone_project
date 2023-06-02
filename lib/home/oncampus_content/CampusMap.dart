import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../various_widget.dart';
import 'CampusMap_asset_hero.dart';

class CampusMap extends StatelessWidget {
   CampusMap({Key? key}) : super(key: key);

   //띄워줄 asset이미지들
  var ImageList = [
    'assets/Campusmap/campusmap_number.png',
    'assets/Campusmap/campusmap.jpeg',
    'assets/Campusmap/Facilities_aroundcampus_dining.png',
    'assets/Campusmap/Facilities_aroundcampus_others.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            'Campus Map', style: onCampusAppBarStyle(),
          ),
          ),

          //contactus와 애니원메일버튼, schoolcontact. 즉 3개 박스 들어감
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 30.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Finding your way'"\n"'around campus', style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp
                    )),
                    Text("\n"' - Konkuk University uses a numbering system to easily identify the various buildings on campus.'
                        "\n\n"' - Please refer to the graph below to see where your classes are held.'"\n", style: TextStyle(
                        color: Color(0xff706F6F),
                        fontSize: 14.sp
                    )),

                    //이미지 1
                    SizedBox(
                      width: 400.w,
                      height: 200.h,
                      child:  GestureDetector(   //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                        child: Hero(
                          tag: ImageList[0],
                          child: Image.asset(ImageList[0]
                            ,
                            fit: BoxFit.fill,),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  CampusMap_asset_hero_image(ImageList[0])  ));
                        },
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),

                    //이미지 2
                    SizedBox(
                      width: 400.w,
                      height:400.h,
                      child: GestureDetector(   //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                        child: Hero(
                          tag: ImageList[1],
                          child: Image.asset(ImageList[1]
                            ,
                            fit: BoxFit.cover,),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  CampusMap_asset_hero_image(ImageList[1])  ));
                        },
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
                    SizedBox(
                      width: 400.w,
                      height: 400.h,
                      child:  GestureDetector(   //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                        child: Hero(
                          tag: ImageList[2],
                          child: Image.asset(ImageList[2]
                            ,
                            fit: BoxFit.fill,),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  CampusMap_asset_hero_image(ImageList[2])  ));
                        },
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),
                    //이미지 4
                    SizedBox(
                      width: 400.w,
                      height: 400.w,
                      child:  GestureDetector(   //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                        child: Hero(
                          tag: ImageList[3],
                          child: Image.asset(ImageList[3]
                            ,
                            fit: BoxFit.fill,),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  CampusMap_asset_hero_image(ImageList[3])  ));
                        },
                      ),
                    ),

                    SizedBox(
                      height: 40.h,
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
