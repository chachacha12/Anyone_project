import 'package:anyone/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shimmer/shimmer.dart';
import '../../../various_widget.dart';
import 'GroceryShop_hero_second.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

//마트, 식료품점 정보
class GroceryShop extends StatefulWidget {
  const GroceryShop({Key? key}) : super(key: key);

  @override
  State<GroceryShop> createState() => _GroceryShopState();
}

class _GroceryShopState extends State<GroceryShop> {

  var grocery_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var count = 0;

  //hero위젯을 통해 전환될 페이지로 보내줄 마트 컨텐츠 문서 하나임. 타입을 dynamic으로해야 어떤 타입이든 받을 수 있어서 이렇게함
  dynamic grocery_document;

  getData() async {
    var result = await firestore.collection('grocery').get();
    setState(() {
      grocery_collection = result.docs; //컬랙션안의 문서리스트를 저장
      count = result.size; //컬랙션안의 문서갯수를 가져옴
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
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0.h,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Container(
                width: 200.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.w),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10.w,2.h, 10.w, 2.h),
                child: Text('Choose a store regarding your needs',
                  textAlign: TextAlign.center, style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),),
              ),

              background: Image.asset(
                'assets/GroceryShop/groceryshopping_background.jpg',
                fit: BoxFit.cover,),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    GestureDetector(
                      child: Card( //리스트 속 각각의 객체 하나하나임
                          elevation: 3,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: 180.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly, //스토어명, 영업시간, 주소, 휴무일정보
                                  children: [
                                    Text(' ' +
                                        grocery_collection[index]['name'] +
                                        '\n',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        )),
                                    richtext(
                                        Icon(Icons.access_time, size: 15.h),
                                        grocery_collection[index]['time']),
                                    richtext(Icon(
                                        Icons.location_on_outlined, size: 15.h),
                                        grocery_collection[index]['address']),
                                    richtext(Icon(Icons.block, size: 15.h),
                                        grocery_collection[index]['holiday']),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0.w, 3.h, 3.h, 3.h),
                                width: 110.w,
                                height: 110.w, //이미지
                                child: Hero(
                                    tag: grocery_collection[index]['name'],
                                    child: Image.network(
                                      grocery_collection[index]['imagepath'][0],
                                      fit: BoxFit.cover,)),
                              )
                            ],
                          )
                      ),
                      onTap: () {
                        grocery_document = grocery_collection[index];
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                GroceryShop_hero_second(grocery_document)));
                      },
                    ),
                childCount: count),
          )
        ],
      ),

    );
  }
}



