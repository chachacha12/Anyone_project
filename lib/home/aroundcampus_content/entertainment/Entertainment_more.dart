import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../various_widget.dart';
import 'Entertainment_hero_image.dart';


class Entertainment_more extends StatefulWidget {
  Entertainment_more(this.entertainment_document, {Key? key}) : super(key: key);
   final entertainment_document;

  @override
  State<Entertainment_more> createState() => _Entertainment_moreState();
}

class _Entertainment_moreState extends State<Entertainment_more> {

  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  var textimagebox;

  @override
  Widget build(BuildContext context) {

    //Cafe.dart에서 가져온 이미지 리스트들을 imgList에 저장. - 타입을 리스트타입으로 바꿔주기 위해
    for (var img in widget.entertainment_document['imagepath']) {
      imgList.add(img);
    }

    //부가설명해주는 텍스트 - 줄바꿈이 파베 firestore에선 되지않아서 여기서 줄바꿈을 해준후 보여주기위함.
    var text = widget.entertainment_document['text'].toString().replaceAll(
        "\\n", "\n");

    //various_widget.dart에 있는 캐러셀슬라이더위젯에 필요한 imageSliders옵션값(이미지리스트)
    List<Widget> imageSliders = Make_imagesliders(imgList);


    if(widget.entertainment_document['textimage'] !=''){
       textimagebox = SizedBox(
         width: double.infinity,
         child: Card(
           child: GestureDetector(   //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
             child: Hero(
               tag: widget.entertainment_document['textimage'],
               child: Image.network(
                 widget.entertainment_document['textimage'],
                 fit: BoxFit.cover,),
             ),
             onTap: (){
               Navigator.push(context, MaterialPageRoute(
                   builder: (context) =>
                       Entertainment_hero_image(widget.entertainment_document['textimage'])));
             },
           ),
         ),
       );
    }else{
      textimagebox = SizedBox(
        height: 0.h,
      );
    }


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            widget.entertainment_document['title'],
          ),
              //backgroundColor: Colors.transparent,
              centerTitle: true,
              floating: true //밑으로 스크롤시 앱바 사라짐
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(0.h, 20.h, 0.h, 0.h),
              child: CarouselSlider( //이미지슬라이드 해주는 위젯
                  options: CarouselOptions(
                    //autoPlay: true,
                    aspectRatio: 2.0,
                    enlargeCenterPage: true,
                  ),
                  items: imageSliders,
                ),
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
                      widget.entertainment_document['category']),

                  richtext(Icon(Icons.monetization_on_outlined, size: 15.h),
                      widget.entertainment_document['time']),

                  richtext(Icon(Icons.access_time, size: 15.h),
                      widget.entertainment_document['address']),

                  richtext(Icon(Icons.block, size: 15.h),
                      widget.entertainment_document['holiday']),

                  textimagebox,
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  //color: Colors.tealAccent
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
