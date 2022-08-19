import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../various_widget.dart';

class Tips_hero_second extends StatefulWidget {
   Tips_hero_second(this.tips_document, {Key? key}) : super(key: key);
  final tips_document ;   //팁 컨텐츠 문서 하나

  @override
  State<Tips_hero_second> createState() => _Tips_hero_secondState();
}


class _Tips_hero_secondState extends State<Tips_hero_second> {
  //팁컨텐츠 하나를 가져옴. 맵타입

  var imgList = [];  //이미지들 주소 string값을 저장해줄 리스트

  @override
  Widget build(BuildContext context) {

    //Tips.dart에서 가져온 이미지 리스트들을 imgList에 저장. - 타입을 리스트타입으로 바꿔주기 위해
    for(var img in widget.tips_document['imagepath']){
      imgList.add(img);
    }

    //팁 부가설명해주는 텍스트 - 줄바꿈이 파베에선 되지않아서 여기서 줄바꿈을 해준후 보여주기위함.
    var text = widget.tips_document['text'].toString().replaceAll("\\n", "\n");

    //various_widget.dart에 있는 캐러셀슬라이더위젯에 필요한 imageSliders옵션값(이미지리스트)
    List<Widget> imageSliders = Make_imagesliders(imgList);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            widget.tips_document['title'],
          ),
            //backgroundColor: Colors.transparent,
            centerTitle: true,
              floating: true  //밑으로 스크롤시 앱바 사라짐
          ),

          SliverToBoxAdapter(
            child: Container(
                  margin: EdgeInsets.fromLTRB(0, 20.h, 0, 0),
                  child: Hero(        //Hero위젯
                    tag: widget.tips_document['title'],
                    child: CarouselSlider(         //이미지슬라이드 해주는 위젯
                      options: CarouselOptions(
                        //autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: imageSliders,
                    ),
                  ),
                ),
            ),

          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
              child: Text(widget.tips_document['tag'], style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.tealAccent
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



