import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

    for(var img in widget.tips_document['imagepath']){
      imgList.add(img);
    }

    //캐러셀슬라이더에 넣어줄 items옵션값을 변수로 만들어줌 - 슬라이드해서 보여줄 이미지들과 텍스트값
    final List<Widget> imageSliders = imgList
        .map((item) => Container(        //item하나하나가 string으로된 사진주소 문자열임.
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(item, fit: BoxFit.cover, width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(

                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),

                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      '',  //No. ${imgList.indexOf(item)} image
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    ))
        .toList();



    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            'tips',
          ),
          ),

          SliverToBoxAdapter(
            child: Container(
                  child: Hero(
                    tag: widget.tips_document['title'],
                    child: CarouselSlider(
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



        ],
      ),
    );
  }
}



