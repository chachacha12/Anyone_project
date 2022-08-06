import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'webView.dart';

//on-campus 관련 정보들을 다 담고있는 박스위젯
class OnCampus extends StatefulWidget {
  const OnCampus({Key? key}) : super(key: key);

  @override
  State<OnCampus> createState() => _OnCampusState();
}
class _OnCampusState extends State<OnCampus> {

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
                  child:  Icon(Icons.star),
                  footer: GridTileBar(
                    title: Text('official'"\n"'site',textAlign: TextAlign.center, style: TextStyle(
                        color: Colors.black
                    )),
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
                  child:  Icon(Icons.star),
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
                  child:  Icon(Icons.star),
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
                  child:  Icon(Icons.star),
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
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Academic'"\n"'Calender',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(                   //GuideBook
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GestureDetector(
                child: GridTile(
                  child:  Icon(Icons.star),
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
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('School'"\n"'Contact',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
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
                      MaterialPageRoute(builder: (context) => MyWebView(link: linkList[6], appbartext: 'Campus Map') )
                  );
                },
              ),
            ),
            Container(                    //clubs
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Clubs',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(                //tips
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Tips',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(               //helplines
              color: Colors.transparent,
              margin: EdgeInsets.all(0.h),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Helplines',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
          ],

      ),
    );
  }
}


