import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../various_widget.dart';
import '../../webView.dart';
import '../cafe/Cafe_hero_image.dart';
import '../cafe/Cafe_more.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

class Restaurant extends StatefulWidget {
  Restaurant({Key? key}) : super(key: key);

  @override
  State<Restaurant> createState() => _RestaurantState();
}


class _RestaurantState extends State<Restaurant> {

  var Restaurant_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임.
  var count = 0;
  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  dynamic restaurant_document; //Cafe_more에 보내줄 식당 컨텐츠 문서 하나. - more은

  getData() async {
    var result = await firestore.collection('restaurant').get();
    setState(() {
      Restaurant_collection = result.docs; //컬랙션안의 문서리스트를 저장
      count = result.size; //컬랙션안의 문서갯수를 가져옴
    });

    //부가설명해주는 텍스트 - 줄바꿈이 파베 firestore에선 되지않아서 여기서 줄바꿈을 해준후 보여주기위함.
    var text = Restaurant_collection['text'].toString().replaceAll("\\n", "\n");
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240.0.h,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('KU students'"'"''"\n"'go-to Restaurant',
                textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),),

              background: Image.asset(
                  'assets/Restaurant/restaurant_background.jpg',
                  fit: BoxFit.cover),
            ),
          ),

          //음식점 리스트 보여줌
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>

                    Container( //컨텐츠 하나하나
                        margin: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row( //가게명, more버튼
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  flex: 4,
                                  child: Text('   ' +
                                      Restaurant_collection[index]['name'],
                                      style: TextStyle(fontSize: 16.sp,
                                          fontWeight: FontWeight.bold)),
                                ),
                                Flexible(
                                  //fit: FlexFit.tight,
                                  flex: 1,
                                  child: OutlinedButton(onPressed: () {
                                    restaurant_document =
                                    Restaurant_collection[index];
                                    //페이지 이동
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            Cafe_more(restaurant_document)));
                                  }, child: Text('more'),),
                                )
                              ],
                            ),

                            Container(
                                margin: EdgeInsets.fromLTRB(
                                    10.w, 0.h, 10.w, 0.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      child: Text(' Naver Map', style:
                                      TextStyle(fontSize: 15.sp,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w400),),
                                      onTap: () async { //네이버지도url scheme을 이용한 딥링크임. 네이버지도앱 실행시켜줄.
                                        var url = Uri.parse(
                                            "nmap://search?query=" +
                                                Restaurant_collection[index]['name'] +
                                                " 건대점" +
                                                "&appname=com.leecha.anyone");

                                        if (await canLaunchUrl(url)) {
                                          await launchUrl(url);
                                        } else {  //네이버지도앱이 없을시
                                          Fluttertoast.showToast(
                                            msg: "Download <Naver Map> Application",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            //fontSize: 20,
                                            //textColor: Colors.white,
                                            //backgroundColor: Colors.redAccent
                                          );
                                          //os기기별로 예외처리해줌
                                          if (Platform.isAndroid) {  //안드로이드폰일때
                                            print("이것은 안드로이드폰!");
                                            //구글플레이앱 바로 실행시켜서 네이버지도검색결과 보여줌
                                            // market:// 이건 구글플레이앱의 url scheme값임 (메니페스트파일에 등록해줘야함 )
                                            var url = Uri.parse("market://details?id=com.nhn.android.nmap");
                                            if(await canLaunchUrl(url)){ //구글플레이 네이버지도링크로 이동가능할때
                                              await launchUrl(url);
                                            }else{
                                              throw 'Cannot move to googleplay link !!';
                                            }
                                          } else if (Platform.isIOS) {   //아이폰일때
                                            print("이것은 아이폰!");
                                            //앱스토어 바로가는 url schem값과 네이버지도 id값. 넣어서 앱스토어 바로 실행 후 네이버지도 다운로드페이지 보여줌
                                            //itms-apps는 앱스토어의 url scheme값임 (info.plist에 등록해줘야함)
                                            var url = Uri.parse("itms-apps://itunes.apple.com/app/id311867728");
                                            if(await canLaunchUrl(url)){ //앱스토어 네이버지도링크로 이동가능할때
                                              await launchUrl(url);
                                            }else{
                                              throw 'Cannot move to appstore link !!';
                                            }
                                          }else{   //안드, 아이폰 둘 다 아닐때
                                            throw 'this is not aos, ios !!!!!';
                                          }
                                        }
                                      },
                                    ),
                                    Text(Restaurant_collection[index]['tag'
                                    ],
                                      style: TextStyle(
                                          fontSize: 15.sp
                                      ),),
                                    richtext(Icon(
                                        Icons.monetization_on_outlined,
                                        size: 15.h),
                                        Restaurant_collection[index]['price']),
                                  ],
                                )
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(0.w, 5.h, 0.w, 0.w),
                              height: 150.0.h,
                              child: ListView.builder( //이미지들 수평리스트로 보여줌
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Restaurant_collection[index]['imagepath']
                                      .length,
                                  itemBuilder: (context, index2) {
                                    return SizedBox(
                                      width: 150.0.w,
                                      child: Card(
                                        child: GestureDetector( //클릭시 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                                          child: Hero(
                                            tag: Restaurant_collection[index]['imagepath'][index2],
                                            child: Image.network(
                                              Restaurant_collection[index]['imagepath'][index2],
                                              fit: BoxFit.cover,),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(
                                                builder: (context) =>
                                                    Cafe_hero_image(
                                                        Restaurant_collection[index]['imagepath'][index2])));
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        )
                    ),
                childCount: count),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 40.h,
            ),
          ),
        ],
      ),
    );
  }
}
