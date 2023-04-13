
import 'package:anyone/home/oncampus_content/CampusMap.dart';
import 'package:anyone/home/oncampus_content/Helplines.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../various_widget.dart';
import 'oncampus_content/School_contact.dart';
import 'oncampus_content/Tips.dart';
import 'oncampus_content/clubs.dart';
import 'webView.dart';
import 'oncampus_content/academic_calender.dart';


//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

//on-campus 관련 정보들을 다 담고있는 박스위젯
class OnCampus extends StatefulWidget {
  const OnCampus({Key? key}) : super(key: key);

  @override
  State<OnCampus> createState() => _OnCampusState();
}


class _OnCampusState extends State<OnCampus> with AutomaticKeepAliveClientMixin {

  //웹뷰띄울 링크들 리스트
  var linkList = [
    'https://www.konkuk.ac.kr/do/Eng/Index.do',
    //official site
    'http://abroad.konkuk.ac.kr/',
    //OIA
    'https://kulhouse.konkuk.ac.kr/home/lan/eng/e_index_01.asp',
    //dormitory
    'http://kli.konkuk.ac.kr/',
    //language institution
    'https://sites.google.com/view/ku-student-guidebook/home',
    //Guide book
    'https://library.konkuk.ac.kr/',
    //Library
    'https://sites.google.com/view/ku-student-guidebook/helpful-information/around-campus?authuser=0',
    //campusmap
  ];

  late bool _isLoading = false; //늦은 초기화 해줌
  var Notice_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임. 이건 식당이 될수도 있고 카페될수도
  var count = 0;
  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  int currentIndex = 0; //캐러셀 사진 슬라이더에 indicator를 달아주기위한 변수
  late List<Widget> imageSliders;

  getData() async {
    _isLoading = true; //여기서 로딩변수 초기화
    var result = await firestore.collection('notice').get();
    print('공지글 getdata실행');

    setState(() {
      _isLoading = false; //데이터받기 끝나면 로딩화면 꺼줌
      Notice_collection = result.docs; //컬랙션안의 문서리스트를 저장
      count = result.size; //컬랙션안의 문서갯수를 가져옴
    });

    //컬렉션안의 문서값을 가져와서 첫번째 이미지들을 저장 (캐러셀슬라이드에 띄우기위함)
    for (var doc in Notice_collection) {
      imgList.add(doc['imagepath'][0].toString());
      print('공지글 이미지 저장: ' + doc['imagepath'][0].toString());
    }
    //various_widget.dart에 있는 캐러셀슬라이더위젯에 필요한 imageSliders옵션값(이미지리스트)
    imageSliders = Make_imagesliders(imgList);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ///what's up 텍스트위젯 + 공지사항 카드들
          Container(
            height: 350.h,
            child: Column(
              children: [

                ///whats up 텍스트
                Container(
                  margin: EdgeInsets.fromLTRB(25.w, 20.h, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text('What' + "'" + 's up', style: TextStyle(
                      color: Color(0xff397D54),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500
                  ),),
                ),

                ///공지사항 카드들 CarouselSlider위젯과 dotsindicator
                _isLoading ? Container() :
                Container(
                    margin: EdgeInsets.fromLTRB(0.h, 20.h, 0.h, 0.h),
                    child: Column( //캐러셀 슬라이드와 indicator 들어감
                      children: [
                        CarouselSlider( //이미지슬라이드 해주는 위젯
                          options: CarouselOptions(
                              autoPlay: true,
                              autoPlayAnimationDuration: Duration(
                                  milliseconds: 800),
                              height: 200.h,
                              viewportFraction: 0.9,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                              enableInfiniteScroll: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              }
                          ),
                          items: imageSliders,
                        ),

                        DotsIndicator(
                          dotsCount: imageSliders.length,
                          position: currentIndex.toDouble(),
                          decorator: DotsDecorator(
                            color: Colors.grey, // Inactive color
                            activeColor: Colors.greenAccent,
                            size: const Size.square(6.0),
                            activeSize: const Size(7.0, 7.0),
                          ),
                        )
                      ],
                    )
                ),
              ],
            ),
          ),

          ///Category 텍스트위젯 + 아이콘 gridView 위젯 2개가 Column으로 있는 박스
          Container(
            color: Color(0xffEAEF9D),
            // height:350.h,
            child: Column(
              children: [

                ///category 텍스트
                Container(
                  margin: EdgeInsets.fromLTRB(25.w, 20.h, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text('Category', style: TextStyle(
                      color: Color(0xff397D54),
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500
                  ),),
                ),

                ///아이콘 gridView 박스
                Container(
                  height: 300.0.h,
                  child: GridView.count(
                    crossAxisCount: 4,
                    children: [
                      Container( //official site
                          color: Colors.transparent,
                          margin: EdgeInsets.all(0.h),
                          child: GestureDetector( //터치기능을 넣기위해 감싸줌
                              child: GridTile(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Image.asset(
                                      'assets/Oncampus_icon/Official Site.png',
                                      width: 35.w, height: 35.w,),
                                    Text('official'"\n"'site',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black
                                        )),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>
                                        MyWebView(link: linkList[0],
                                            appbartext: 'official site'),)
                                );
                              }
                          )
                      ),
                      Container( //OIA
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Oncampus_icon/OIA.png', width: 35.w,
                                  height: 35.w,), //Icon(Icons.star),
                                Text('OIA', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),

                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MyWebView(
                                        link: linkList[1], appbartext: 'OIA'))
                            );
                          },
                        ),
                      ),
                      Container( //dormitory
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Oncampus_icon/dormitory.png',
                                  width: 35.w, height: 35.w,),
                                //Icon(Icons.star),
                                Text('Dormitory', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MyWebView(link: linkList[2],
                                        appbartext: 'Dormitory'))
                            );
                          },
                        ),
                      ),
                      Container( //language institution
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Oncampus_icon/Language Institution.png',
                                  width: 35.w, height: 35.w,),
                                //Icon(Icons.star),
                                Text('Language'"\n"'Institution',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MyWebView(link: linkList[3],
                                        appbartext: 'Language Institution'))
                            );
                          },
                        ),
                      ),
                      Container( //academic calender
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Oncampus_icon/Academic calendar 2.png',
                                  width: 35.w, height: 35.w,),
                                //Icon(Icons.star),
                                Text('Academic'"\n"'Calender',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    Calender()) //Calender 커스텀위젯을 보여줌
                            );
                          },
                        ),
                      ),
                      Container( //GuideBook
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Oncampus_icon/Guidebook.png',
                                  width: 35.w, height: 35.w,),
                                //Icon(Icons.star),
                                Text('Guide'"\n"'Book',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MyWebView(link: linkList[4],
                                        appbartext: 'GuideBook'))
                            );
                          },
                        ),
                      ),
                      Container( //Library
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/Oncampus_icon/Library.png',
                                  width: 35.w, height: 35.w,),
                                //Icon(Icons.star),
                                Text('Library', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    MyWebView(link: linkList[5],
                                        appbartext: 'Library'))
                            );
                          },
                        ),
                      ),
                      Container( //school contact
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset('assets/Oncampus_icon/Contact.png',
                                  width: 35.w, height: 35.w,),
                                //Icon(Icons.star),
                                Text('School'"\n"'Contact',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Contact())
                            );
                          },
                        ),
                      ),
                      Container( //Campus map
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Oncampus_icon/Campus Map.png',
                                  width: 35.w, height: 35.w,),
                                //Icon(Icons.star),
                                Text('Campus'"\n"'Map',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CampusMap())
                            );
                          },
                        ),
                      ),
                      Container( //clubs
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Oncampus_icon/Clubs.png', width: 35.w,
                                  height: 35.w,), //Icon(Icons.star),
                                Text('Clubs', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Clubs())
                            );
                          },
                        ),
                      ),
                      Container( //tips
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Oncampus_icon/Tips.png', width: 35.w,
                                  height: 35.w,), //Icon(Icons.star),
                                Text('Tips', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Tips())
                            );
                          },
                        ),
                      ),
                      Container( //helplines
                        color: Colors.transparent,
                        margin: EdgeInsets.all(0.h),
                        child: GestureDetector(
                          child: GridTile(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  'assets/Oncampus_icon/Helplines.png',
                                  width: 35.w, height: 35.w,),
                                //Icon(Icons.star),
                                Text('Helplines', textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black
                                    )),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Helplines())
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )

              ],
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

