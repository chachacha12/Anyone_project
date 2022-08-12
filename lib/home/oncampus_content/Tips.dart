import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;


class Tips extends StatefulWidget {
   Tips({Key? key}) : super(key: key);

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> {

  var tips_collection;  //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var count=0;

  getData() async {
    var result = await firestore.collection('tips').get();

    setState(() {
      tips_collection = result.docs;   //컬랙션안의 문서리스트를 저장
      count = result.size;  //컬랙션안의 문서갯수를 가져옴
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            'Tips',
          ),
          ),

          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //mainAxisExtent: 2,
              crossAxisCount: 2,
              crossAxisSpacing: 0.h,
              mainAxisSpacing: 0.h,
              childAspectRatio: 0.6.h,   //요소하나당 가로세로 비율값임. 공간 침범해서 에러나면 이값을 높이거나 낮춰보기.
            ),

            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {

                return Container(
                  margin: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0.h),
                  child: Column(
                    children: [
                      Container(
                        child: Image.network(tips_collection[index]['imagepath'][0], fit: BoxFit.fill),  //첫번째 이미지만 가져와서 보여줌
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        height: 150.h,
                        width: 150.h,
                      ),
                      //Spacer(flex: 2,),
                      Container(
                        margin: EdgeInsets.fromLTRB(0.h, 5.h, 0.h, 5.h),
                        child: Text(tips_collection[index]['title'],  textAlign: TextAlign.center),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        width: 150.h,
                        height: 20.h,
                      ),
                      Container(
                        child: Text(tips_collection[index]['tag'], textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.sp),),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        width: 150.h,
                        height: 30.h,
                      ),
                    ],
                  ),
                );
              },
              childCount: count,
            ),
          ),

        ],
      ),
    );
  }
}
