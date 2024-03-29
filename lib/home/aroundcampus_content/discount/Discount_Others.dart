import 'package:anyone/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../NaverMapDeepLink.dart';
import '../../../various_widget.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;


class Discount_Others extends StatefulWidget {
  Discount_Others(this.collection, this.count,{Key? key}) : super(key: key);
   final collection;
   final count;

  @override
  State<Discount_Others> createState() => _Discount_OthersState();
}

class _Discount_OthersState extends State<Discount_Others> {


  @override
  void initState() {
    super.initState();
    //getData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [

          //문서 리스트 보여줌
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    Card( //리스트 속 각각의 객체 하나하나임
                          elevation: 1,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 15.w),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 200.w,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(' '+widget.collection[index]['name']+'\n',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      )),

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //네이버맵 url scheme값을 이용해서 딥링크 연결하는 동작을 위한 커스텀위젯
                                          //인자값으로 각 컨텐츠의 풀네임값을 보내줌
                                          NaverMapDeepLink( titlename :widget.collection[index]['name']),
                                          //파베 띄어쓰기해줌
                                          Text(widget.collection[index]['contents'].toString().replaceAll("\\n", "\n"),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 14.sp,
                                            ),)
                                        ],
                                      )
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  width: 110.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      //이미지
                                      Container(
                                          margin: EdgeInsets.fromLTRB(0, 0.h, 3.h, 3.h),
                                          width: 110.w,
                                          height: 110.w, //이미지
                                          child: Image.network(
                                            widget.collection[index]['imagepath'],
                                            fit: BoxFit.fill,)
                                      ),
                                      richtext(Icon(
                                          Icons.label_important, size: 15.h),
                                          widget.collection[index]['category']),

                                    ],

                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                childCount: widget.count),
          ),
        ],
      ),
    );
  }
}



