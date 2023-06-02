import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

//사진 이미지 클릭시 하나의 이미지 전체화면으로 나오고 줌인해서 볼 수 있게 해주는 위젯
class Extend_HeroImage extends StatefulWidget {
  Extend_HeroImage(this.ImagepathList, this.index, {Key? key}) : super(key: key);
  final ImagepathList;
  final index;

  @override
  State<Extend_HeroImage> createState() => _Extend_HeroImageState();
}

class _Extend_HeroImageState extends State<Extend_HeroImage> {
  //이미지들 주소 string값을 저장해줄 리스트
  List<Widget> imgList = [];
  //캐러셀 사진 슬라이더에 indicator를 달아주기위한 변수
  int currentIndex=0;
  //사진 하나인지 여러개의 리스트인지 구분하기 위함
  bool _isSinglePhoto=false;

  @override
  Widget build(BuildContext context) {
    //캐러셀 슬라이드로 이미지 하나 스와이프 할때마다 이 build()함수는 계속 호출됨..그래서
    //리스트에 이미지가 계속 추가되기 때문에..indicator갯수가 계속 많아지는 문제 발생. 그래서 이미지리스트 한번 비워줌
     imgList.clear();

     ///사진을 String으로 한개만 전달받았을때와 리스트형으로 여러개 전달받았을때를 구분
    if(widget.ImagepathList is String){  // 이미지 한개만 전달받았을때
      _isSinglePhoto = true;
    }else{  // String이미지 주소값들이 있는 list형일때
      for (var img in widget.ImagepathList) {
        var photo = PhotoView(
          imageProvider: NetworkImage(img),
        );
        imgList.add(photo);
      }
    }

    return Scaffold(
      body: Stack(
        children: [
          ///삼항연산자를 통해 단일사진일때와 리스트일때 각각 다른 위젯을 보여줌
          _isSinglePhoto ? PhotoView(
            //heroAttributes: PhotoViewHeroAttributes(tag: widget.ImagepathList),
            imageProvider: NetworkImage(widget.ImagepathList),
          ):
          CarouselSlider( //이미지슬라이드 해주는 위젯
            options: CarouselOptions(
                initialPage: widget.index,
                height: double.infinity,
                viewportFraction: 1.0,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                onPageChanged: (i, reason){
                  setState((){
                    currentIndex = i;
                    print(currentIndex);
                  });
                }
            ),
            items: imgList,
          ),

          Positioned(
              top: 30.h,
              right: 13.w,
              child: IconButton(
                iconSize: 25.w,
                color: Colors.white,
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
          )
        ],
      ),
    );

  }
}
