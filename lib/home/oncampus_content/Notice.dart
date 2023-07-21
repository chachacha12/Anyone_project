import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Extend_HeroImage.dart';
import '../../various_widget.dart';

///공지사항들 디테일하게 보여주는 위젯
class Notice extends StatefulWidget {
  const Notice(this.notice_document, {Key? key}) : super(key: key);
  final notice_document;

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {

  getRelatedLink(){

    if(widget.notice_document['link']=='' ){  ///링크가 없다면
      return Container(
        color: Colors.white,
        height: 10.h,
      );
    }else{  ///링크값이 있다면
      return Container(
        alignment: Alignment.centerLeft,
        color: Colors.white,
        child: TextButton(
          child: Text('     Go to the link',
          ),
          onPressed: (){
            launch(widget.notice_document['link']);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    //부가설명해주는 텍스트 - 줄바꿈이 파베 firestore에선 되지않아서 여기서 줄바꿈을 해준후 보여주기위함.
    var title = widget.notice_document['title'].toString().replaceAll(
        "\\n", "\n");

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            widget.notice_document['title'], maxLines: 3,
            style: onCampusAppBarStyle(),
          ),
              //backgroundColor: Colors.transparent,
              centerTitle: true,
              floating: true //밑으로 스크롤시 앱바 사라짐
          ),

          ///관련 링크가 있다면 띄워주는 함수
          SliverToBoxAdapter(
              child: getRelatedLink()
          ),

          ///사진 이미지 하나씩 보여줌
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    Container(
                      color: Colors.white,
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 25.h),
                        color: Colors.white,
                        child: Container( //컨텐츠 하나하나
                            margin: EdgeInsets.symmetric(
                                vertical: 0.h, horizontal: 10.w),
                            child: GestureDetector(child: Image.network(
                                widget.notice_document['imagepath'][index]),

                              ///사진 하나 클릭시 확대해주고 옆으로 슬라이드하면서 볼 수 있게 하는 위젯 띄워줌
                              onTap: (){
                                Navigator.push(
                                    context, MaterialPageRoute(
                                    builder: (context) =>
                                        Extend_HeroImage(
                                            widget.notice_document['imagepath'],
                                            index)));
                              },
                            )
                        ),
                      ),
                    ),
                childCount: widget.notice_document['imagepath'].length),
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
