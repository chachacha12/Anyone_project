import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../various_widget.dart';
import '../aroundcampus_content/CommonWidget.dart';

class Tips_hero_second extends StatefulWidget {
   Tips_hero_second(this.tips_document, {Key? key}) : super(key: key);
  final tips_document ;   //팁 컨텐츠 문서 하나

  @override
  State<Tips_hero_second> createState() => _Tips_hero_secondState();
}


class _Tips_hero_secondState extends State<Tips_hero_second> {
  //팁컨텐츠 하나를 가져옴. 맵타입

  var imgList = [];  //이미지들 주소 string값을 저장해줄 리스트
  int currentIndex =0; //캐러셀 사진 슬라이더에 indicator를 달아주기위한 변수

  @override
  Widget build(BuildContext context) {

    //Tips.dart에서 가져온 이미지 리스트들을 imgList에 저장. - 타입을 리스트타입으로 바꿔주기 위해
    for(var img in widget.tips_document['imagepath']){
      imgList.add(img);
    }

    //팁 부가설명해주는 텍스트 - 줄바꿈이 파베에선 되지않아서 여기서 줄바꿈을 해준후 보여주기위함.
    //var text = widget.tips_document['text'].toString().replaceAll("\\n", "\n");

    //various_widget.dart에 있는 캐러셀슬라이더위젯에 필요한 imageSliders옵션값(이미지리스트)
    List<Widget> imageSliders = Make_imagesliders(imgList);
    //캐러셀 슬라이드로 이미지 하나 스와이프 할때마다 리스트에 이미지가 계속 추가되기 때문에..indicator갯수가 계속 많아지는 문제 발생. 그래서 이미지리스트 한번 비워줌
    imgList.clear();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            widget.tips_document['title'].toString().replaceAll(
          "\\n", "\n"),
              style: getMorePageAppBarStyle()  ///CommonWidget안에 있는 앱바스타일
          ),
            //backgroundColor: Colors.transparent,
            centerTitle: true,
              floating: true  //밑으로 스크롤시 앱바 사라짐
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
                  padding: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
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
                          activeColor: Color(0xff73c088),
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
              color: Colors.white,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
              child: Text(widget.tips_document['tag'], textAlign: TextAlign.center,style: TextStyle(
                color: Color(0xff706F6F),

                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),

          //소주제들 리스트 하나씩 보여줌
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    Container( //컨텐츠 하나하나
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //소주제 제목, 사진, 텍스트 순으로 넣어줌
                          children: [
                            Text('${index+1}'+'. '+widget.tips_document['sub'][index]['title']+'\n',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),),

                            //파베 뛰어쓰기해줌. --> toString().replaceAll("\\n", "\n"
                            Text(widget.tips_document['sub'][index]['text'].toString().replaceAll("\\n", "\n"),
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.normal,
                              ),)
                          ],
                        )
                    ),
                childCount: widget.tips_document['sub'].length),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 140.h,
            ),
          ),

        ],
      ),
    );
  }
}



