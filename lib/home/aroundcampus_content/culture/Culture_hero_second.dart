import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../various_widget.dart';


class Culture_hero_second extends StatefulWidget {
  Culture_hero_second(this.culture_document, {Key? key}) : super(key: key);
  final culture_document ;   //팁 컨텐츠 문서 하나

  @override
  State<Culture_hero_second> createState() => _Culture_hero_secondState();
}


class _Culture_hero_secondState extends State<Culture_hero_second> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            widget.culture_document['title'],
          ),
            //backgroundColor: Colors.transparent,
            centerTitle: true,
              floating: true  //밑으로 스크롤시 앱바 사라짐
          ),

          SliverToBoxAdapter(
            child: Container(
                  margin: EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.w),
                  child: Hero(        //Hero위젯
                    tag: widget.culture_document['title'],
                    child: Image.network(widget.culture_document['imagepath'], fit: BoxFit.cover,)
                  ),
                ),
            ),

          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 0),
              child: Text(widget.culture_document['tag'], style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,),
            ),
          ),

          //소주제들 리스트 하나씩 보여줌
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
 
                    Container( //컨텐츠 하나하나
                        margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //소주제 제목, 사진, 텍스트 순으로 넣어줌
                          children: [
                            Text('${index+1}'+'. '+widget.culture_document['sub'][index]['title']+'\n',
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                              ),),

                            //이미지 없으면 그냥 박스만 넣어줄거임
                            Image.network(widget.culture_document['sub'][index]['image']),

                            Text(widget.culture_document['sub'][index]['text'])
                          ],
                          
                        )
                    ),
                childCount: widget.culture_document['sub'].length),
          ),


        ],
      ),
    );
  }
}



