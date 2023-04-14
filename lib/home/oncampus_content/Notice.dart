import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

///공지사항들 디테일하게 보여주는 위젯
class Notice extends StatefulWidget {
  const Notice(this.notice_document, {Key? key}) : super(key: key);
  final notice_document;

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {

    //부가설명해주는 텍스트 - 줄바꿈이 파베 firestore에선 되지않아서 여기서 줄바꿈을 해준후 보여주기위함.
    var text = widget.notice_document['text'].toString().replaceAll(
        "\\n", "\n");
    
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            widget.notice_document['title'], maxLines: 3,
          ),
              //backgroundColor: Colors.transparent,
              centerTitle: true,
              floating: true //밑으로 스크롤시 앱바 사라짐
          ),


          ///설명글 박스
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
