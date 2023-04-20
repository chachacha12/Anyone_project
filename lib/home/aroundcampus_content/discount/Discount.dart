import 'package:anyone/home/aroundcampus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Discount_Cafe.dart';
import 'Discount_Others.dart';
import 'Discount_Restaurant.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

////여기서 식당, 카페, ohters 데이터들 다 각각 미리 받을거임
class Discount extends StatefulWidget {
  const Discount({Key? key}) : super(key: key);

  @override
  State<Discount> createState() => _DiscountState();
}


class _DiscountState extends State<Discount>  {

  //식당
  var discount_restaurant_collection;
  var discount_restaurant_count=0;

  //카페
  var discount_cafe_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var discount_cafe_count=0;

  //others
  var discount_others_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var discount_others_count=0;


  getData() async {
    var result = await firestore.collection('discount_restaurant').get();

    var result2 = await firestore.collection('discount_cafe').get();

    var result3 = await firestore.collection('discount_others').get();

    setState(() {
      discount_restaurant_collection = result.docs; //컬랙션안의 문서리스트를 저장
      discount_restaurant_count = result.size;

      discount_cafe_collection = result2.docs; //컬랙션안의 문서리스트를 저장
      discount_cafe_count = result2.size;

      discount_others_collection = result3.docs; //컬랙션안의 문서리스트를 저장
      discount_others_count = result3.size;

    });

  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[

                SliverAppBar(
                  pinned: true,
                  expandedHeight: 200.0.h,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title:
                    Text('Show your student ID,\nGet discount !\n\n',
                        textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 16.sp),),
                    background: Image.asset(
                      'assets/Discount/Discount_background.jpg',
                      fit: BoxFit.cover,),
                  ),
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Restaurant',),
                      Tab(text: 'Cafe',),
                      Tab(text: 'Others',)
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 2,
                    indicatorColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(fontSize: 15.sp),
                    labelStyle: TextStyle(
                        fontSize:21.sp, fontWeight: FontWeight.w500),

                    ),
                ),

              ];
            },
            body: TabBarView(
              children: <Widget>[
                Discount_Restaurant(discount_restaurant_collection, discount_restaurant_count),
                Discount_Cafe(discount_cafe_collection, discount_cafe_count),
                Discount_Others(discount_others_collection, discount_others_count),
                // Discount_Cafe(), Discount_Others()
              ],
            ),
          )),
    );
  }
}

