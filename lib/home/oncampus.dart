
import 'package:anyone/home/oncampus_content/CampusMap.dart';
import 'package:anyone/home/oncampus_content/Helplines.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'oncampus_content/School_contact.dart';
import 'oncampus_content/Tips.dart';
import 'oncampus_content/clubs.dart';
import 'webView.dart';
import 'oncampus_content/academic_calender.dart';

//on-campus 관련 정보들을 다 담고있는 박스위젯
class OnCampus extends StatefulWidget {
  const OnCampus({Key? key}) : super(key: key);

  @override
  State<OnCampus> createState() => _OnCampusState();
}
class _OnCampusState extends State<OnCampus> with AutomaticKeepAliveClientMixin{

  //웹뷰띄울 링크들 리스트
  var linkList = [
    'https://www.konkuk.ac.kr/do/Eng/Index.do',  //official site
    'http://abroad.konkuk.ac.kr/',  //OIA
    'https://kulhouse.konkuk.ac.kr/home/lan/eng/e_index_01.asp', //dormitory
    'http://kli.konkuk.ac.kr/', //language institution
    'https://sites.google.com/view/ku-student-guidebook/home', //Guide book
    'https://library.konkuk.ac.kr/en/#/', //Library
    'https://sites.google.com/view/ku-student-guidebook/helpful-information/around-campus?authuser=0', //campusmap
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500.0.h,
      //width: double.infinity.w,
      child: GridView.count(
          crossAxisCount: 4,
          children: [
            Container(         //official site
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(   //터치기능을 넣기위해 감싸줌
                child: GridTile(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset('assets/KakaoTalk_Photo_2022-08-22-11-57-23 001.png', width: 40.w, height: 40.w,),
                      Text('official'"\n"'site',textAlign: TextAlign.center, style: TextStyle(
                          color: Colors.black
                      )),
                    ],
                  ),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyWebView(link: linkList[0], appbartext: 'official site'),)
                  );
                }
              )
            ),
            Container(                  //OIA
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:   Image.asset('assets/KakaoTalk_Photo_2022-08-22-11-57-23 002.png', fit: BoxFit.cover),//Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('OIA',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyWebView(link: linkList[1], appbartext: 'OIA') )
                  );
                },
              ),
            ),
            Container(                 //dormitory
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:   Image.asset('assets/KakaoTalk_Photo_2022-08-22-11-57-23 003.png'),//Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('Dormitory',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyWebView(link: linkList[2], appbartext: 'Dormitory') )
                  );
                },
              ),
            ),
            Container(          //language institution
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Image.asset('assets/KakaoTalk_Photo_2022-08-22-11-57-24 004.png'),//Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('Language'"\n"'Institution',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyWebView(link: linkList[3], appbartext: 'Language Institution') )
                  );
                },
              ),
            ),
            Container(           //academic calender
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Image.asset('assets/KakaoTalk_Photo_2022-08-22-11-57-24 005.png'),//Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('Academic'"\n"'Calender',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Calender())    //Calender 커스텀위젯을 보여줌
                  );
                },
              ),
            ),
            Container(                   //GuideBook
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Image.asset('assets/KakaoTalk_Photo_2022-08-22-11-57-24 006.png'),//Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('Guide'"\n"'Book',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyWebView(link: linkList[4], appbartext: 'GuideBook') )
                  );
                },
              ),
            ),
            Container(                      //Library
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('Library',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyWebView(link: linkList[5], appbartext: 'Library') )
                  );
                },
              ),
            ),
            Container(                 //school contact
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('School'"\n"'Contact',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Contact()  )
                  );
                },
              ),
            ),
            Container(                    //Campus map
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('Campus'"\n"'Map',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CampusMap() )
                  );
                },
              ),
            ),
            Container(                    //clubs
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('Clubs',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Clubs() )
                  );
                },
              ),
            ),
            Container(                //tips
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('Tips',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Tips() )
                  );
                },
              ),
            ),
            Container(               //helplines
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('Helplines',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
                  ),
                ),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Helplines() )
                  );
                },
              ),
            ),
          ],

      ),
    );
  }

  //이 페이지 상태유지를 위한 함수
  @override
  bool get wantKeepAlive => true;
}


