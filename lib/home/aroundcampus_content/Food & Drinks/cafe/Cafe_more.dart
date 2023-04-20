import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../various_widget.dart';

//식당 리스트, 카페 리스트 등 여러가지 장소리스트를 여기서 받아서 장소정보 자세히 보여주는 페이지임
class Cafe_more extends StatefulWidget {
   Cafe_more(this.cafe_document, {Key? key}) : super(key: key);
   final cafe_document;

  @override
  State<Cafe_more> createState() => _Cafe_moreState();
}

class _Cafe_moreState extends State<Cafe_more> {

  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  int currentIndex =0; //캐러셀 사진 슬라이더에 indicator를 달아주기위한 변수

  @override
  Widget build(BuildContext context) {
    //Cafe.dart에서 가져온 이미지 리스트들을 imgList에 저장. - 타입을 리스트타입으로 바꿔주기 위해
    for (var img in widget.cafe_document['imagepath']) {
      imgList.add(img);
      print('imgList에 이미지 저장'+img);
    }

    //부가설명해주는 텍스트 - 줄바꿈이 파베 firestore에선 되지않아서 여기서 줄바꿈을 해준후 보여주기위함.
    var text = widget.cafe_document['text'].toString().replaceAll(
        "\\n", "\n");

    //various_widget.dart에 있는 캐러셀슬라이더위젯에 필요한 imageSliders옵션값(이미지리스트)
    List<Widget> imageSliders = Make_imagesliders(imgList);
    //캐러셀 슬라이드로 이미지 하나 스와이프 할때마다 리스트에 이미지가 계속 추가되기 때문에..indicator갯수가 계속 많아지는 문제 발생. 그래서 이미지리스트 한번 비워줌
    imgList.clear();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            widget.cafe_document['name'], maxLines: 3,
          ),
              //backgroundColor: Colors.transparent,
              centerTitle: true,
              floating: true //밑으로 스크롤시 앱바 사라짐
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(0.h, 20.h, 0.h, 0.h),
              child: Column(  //캐러셀 슬라이드와 indicator 들어감
                children: [
                  CarouselSlider( //이미지슬라이드 해주는 위젯
                    options: CarouselOptions(
                        autoPlay: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        height: 200.h,
                        viewportFraction: 0.9,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason){
                          setState((){
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
                      color: Colors.grey,  // Inactive color
                      activeColor: Colors.greenAccent,
                      size: const Size.square(6.0),
                      activeSize: const Size(7.0, 7.0),
                    ),
                  )
                ],
              )
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(40.w, 10.h, 20.w, 0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  richtext(null,
                      widget.cafe_document['tag']),

                  richtext(Icon(Icons.monetization_on_outlined, size: 15.h),
                      widget.cafe_document['price']),

                  richtext(Icon(Icons.access_time, size: 15.h),
                      widget.cafe_document['time']),

                  richtext(Icon(Icons.block, size: 15.h),
                      widget.cafe_document['holiday']),

                  richtext(Icon(Icons.location_on_outlined, size: 15.h),
                      widget.cafe_document['address']),

                  /*
                   richtext(Icon(Icons.contact_mail_outlined, size: 15.h),
                      widget.cafe_document['contact']),
                   */
                  richtext(Container(
                      //color: Colors.red,
                      width: 14.w, height: 14.w,
                      margin: EdgeInsets.fromLTRB(1.5.w, 0.w, 0.w, 0.w),
                      child: Image.asset(
                    'assets/Instagram.png', fit: BoxFit.fill, )),
                      widget.cafe_document['contact']),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  //color: Colors.white
              ),
              margin: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 50.h),
              padding: EdgeInsets.all(15.w),
              child: Text(text, style: TextStyle(
                  fontSize: 15.sp
              ),),
            ),
          )

        ],
      ),
    );
  }
}
