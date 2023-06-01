import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../various_widget.dart';
import '../CommonWidget.dart';


class Culture_hero_second extends StatefulWidget {
  Culture_hero_second(this.culture_document, {Key? key}) : super(key: key);
  final culture_document ;   //팁 컨텐츠 문서 하나

  @override
  State<Culture_hero_second> createState() => _Culture_hero_secondState();
}


class _Culture_hero_secondState extends State<Culture_hero_second> {


  //파베 db에 이미지가 '' 이렇게 비어있는 필드일때를 위한 메소드
  get_TextImageBox(imagepath) {
    if(imagepath != ''){   //소주제의 이미지가 비어있지않다면
      return Image.network(imagepath);
    }else{
      return SizedBox(height: 0.h);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            widget.culture_document['title'].toString().replaceAll(
          "\\n", "\n"), maxLines: 3,textAlign: TextAlign.center,
              style: getMorePageAppBarStyle()  ///CommonWidget안에 있는 앱바스타일
          ),
            //backgroundColor: Colors.transparent,
              centerTitle: true,
              floating: true  //밑으로 스크롤시 앱바 사라짐
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
                  child: Hero(        //Hero위젯
                    tag: widget.culture_document['title'].toString().replaceAll(
    "\\n", "\n"),
                    child: Image.network(widget.culture_document['imagepath'], fit: BoxFit.cover,)
                  ),
                ),
            ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
                child: Text(widget.culture_document['tag'], style: TextStyle(
                  color: Color(0xff706F6F),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,),
              ),
            ),
          ),

          //소주제들 리스트 하나씩 보여줌
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
 
                    Container(
                      color: Colors.white,
                      child: Container( //컨텐츠 하나하나
                          margin: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //소주제 제목, 사진, 텍스트 순으로 넣어줌
                            children: [
                              Text(widget.culture_document['sub'][index]['title'],
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                ),),

                              //소주제의 이미지가 있다면 이미지 보여줌.
                              get_TextImageBox(widget.culture_document['sub'][index]['image']),

                              //파베 뛰어쓰기해줌. --> toString().replaceAll("\\n", "\n"
                              Text(widget.culture_document['sub'][index]['text'].toString().replaceAll("\\n", "\n"),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),)
                            ],

                          )
                      ),
                    ),
                childCount: widget.culture_document['sub'].length),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 120.h,
            ),
          ),

        ],
      ),
    );
  }
}



