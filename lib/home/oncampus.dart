import 'package:anyone/home/oncampus_content/CampusMap.dart';
import 'package:anyone/home/oncampus_content/Helplines.dart';
import 'package:anyone/home/oncampus_content/Notice.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../loading/shimmerloadinglist.dart';
import '../various_widget.dart';
import 'oncampus_content/School_contact.dart';
import 'oncampus_content/Tips.dart';
import 'oncampus_content/Tips_hero_second.dart';
import 'oncampus_content/clubs.dart';
import 'webView.dart';
import 'oncampus_content/academic_calender.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;
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

//on-campus 관련 정보들을 다 담고있는 박스위젯
class OnCampus extends StatefulWidget {
  const OnCampus({Key? key}) : super(key: key);

  @override
  State<OnCampus> createState() => _OnCampusState();
}

class _OnCampusState extends State<OnCampus> with AutomaticKeepAliveClientMixin {

  ///공지사항 데이터를 위해 필요한 변수들
  late bool _isNoticeLoading = false; //공지사항 데이터 가져올때 늦은 초기화 해줌
  var noticeCollection; //파이어스토어로부터 받아올 공지사항 문서들 리스트를 여기에 넣어줄거임.
  var noticeImgList = []; //공지사항 이미지들 주소 string값을 저장해줄 리스트
  int currentIndex = 0; //공지사항 캐러셀 사진 슬라이더에 indicator를 달아주기위한 변수
  late List<Widget> imageSliders;
  dynamic notice_document;
  ///팁 데이터를 위해 필요한 변수들
  late bool _isTipLoading = false; // 팁 데이터 가져올때 늦은 초기화
  var tipsCollection;
  var tipsCount=0;  //팁 문서의 전체 갯수


  getData() async {
    _isNoticeLoading = true; //여기서 공지사항 로딩화면뜸
    _isTipLoading = true; //여기서 데이터 로딩화면 뜸
    var result = await firestore.collection('notice').get();
    var result2 = await firestore.collection('tips').get();

    setState(() {
      _isNoticeLoading = false; //공지사항 데이터받기 끝나면 로딩화면 꺼줌
      _isTipLoading = false; //팁 데이터
      noticeCollection = result.docs; //공지사항 컬랙션안의 문서리스트를 저장
      tipsCollection = result2.docs; //팁 컬렉션
    });

    //공지사항 컬렉션안의 문서값을 가져와서 첫번째 이미지들을 저장 (캐러셀슬라이드에 띄우기위함)
    for (var doc in noticeCollection) {
      noticeImgList.add(doc['imagepath'][0].toString());
      print('공지글 이미지 저장: ' + doc['imagepath'][0].toString());
    }
    //various_widget.dart에 있는 캐러셀슬라이더위젯에 필요한 imageSliders옵션값(이미지리스트)
    imageSliders = Make_imagesliders(noticeImgList);

    //팁 문서의 전체 갯수를 저장해줌. 리스트만들때 필요
    for(var doc in tipsCollection){
      tipsCount++;
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          ///what's up 텍스트위젯 + 공지사항 카드들
          Container(
            height: 300.h,
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
                _isNoticeLoading ? Container() :
                Container(
                    margin: EdgeInsets.fromLTRB(0.h, 20.h, 0.h, 0.h),
                    child: Column( //캐러셀 슬라이드와 indicator 들어감
                      children: [
                        GestureDetector(
                          onTap: (){
                            notice_document =
                            noticeCollection[currentIndex]; //선택한 팁 컨텐츠 문서하나를 전환될 페이지에 보내주기위해 저장
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Notice(notice_document))
                            );
                          },
                          child:  CarouselSlider( //이미지슬라이드 해주는 위젯
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

          ///아이콘들있는 박스를 커스텀위젯으로 빼둠
          OnCampusCategory(),

          ///Facility & CampusTip 있는 박스
          Container(
            height: 400.h,
            child: Column(
              children: [
                ///whats up 텍스트
                Container(
                  margin: EdgeInsets.fromLTRB(25.w, 30.h, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Text('Facility & Campus Tips', style: TextStyle(
                      color: Color(0xff397D54),
                      fontSize: 21.sp,
                      fontWeight: FontWeight.w500
                  ),),
                ),

                ///팁 리스트들. 데이터요청 안끝났으면 로딩화면 보여주고있을거임
                _isTipLoading ? ShimmerLoadingList() :
                Container(
                  margin: EdgeInsets.fromLTRB(0.w, 15.h, 0.w, 0.w),
                  height: 180.0.h,
                  child: ListView.builder( //이미지들 수평리스트로 보여줌
                      scrollDirection: Axis.horizontal,
                      itemCount: tipsCount,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.fromLTRB(5.w, 0, 0, 0),
                          width: 150.0.w,
                          //height: 150.0.h,
                          child: Card(
                            child: GestureDetector( //클릭시 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                              child: Stack( //이미지와 텍스트를 겹치게 할때 주로 사용
                                fit: StackFit.expand,
                                children: [
                                  Hero(
                                    tag: tipsCollection[index]['imagepath'][0],
                                    //랜덤리스트의 0번째 인덱스값부터 넣음- 랜덤하게 보여줌
                                    child: Image.network(
                                      tipsCollection[index]['imagepath'][0],
                                      fit: BoxFit.cover,),
                                  ),
                                  Positioned(child: Text('  '+tipsCollection[index]['title'],
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),),
                                    bottom: 3.h,)
                                ],
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                    //카페와 식당 db의 필드가 같아서 카페에서 갔다씀
                                    Tips_hero_second( tipsCollection[index])));
                              },
                            ),
                          ),
                        );
                      }),
                ),


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






///Category 텍스트위젯 + 아이콘 gridView 위젯 2개가 Column으로 있는 박스를 커스텀위젯으로 만듬
class OnCampusCategory extends StatelessWidget {
  const OnCampusCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Container(
          //박스 테두리 주기
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide( // POINT
                color:  Colors.grey,
                width: 1.0,
              ),
              top: BorderSide( // POINT
                color:  Colors.grey,
                width: 1.0,
              ),
            ),
            color: Color(0xffEAEF9D),
          ),

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
              height: 220.0.h,
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
                            Text('School'"\n"'Clubs', textAlign: TextAlign.center,
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

                  /*
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
                       */
                ],
              ),
            )

          ],
        ),
      );
  }
}
