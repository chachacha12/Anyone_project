import 'package:anyone/MyList/MyListPages/EnterMyList.dart';
import 'package:anyone/MyList/MyListPages/FashionMyList.dart';
import 'package:anyone/MyList/MyListPages/PubMyList.dart';
import 'package:anyone/MyList/MyListPages/RestaurantMyList.dart';
import 'package:anyone/home/aroundcampus_content/Food%20&%20Drinks/restaurant/Restaurant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'MyListPages/CafeMyList.dart';
import 'MyListPages/GroceryMyList.dart';

///내 찜목록 메인페이지 - 이곳에서 식당, 카페 등 컨텐츠별로 위젯 바꿔끼면서 보여줌
class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: AppBar(
            title: Text('My List', style: TextStyle(color: Colors.black)),
           // toolbarHeight: 20.h, ///탭바의 전체적인 길이를 조절
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Restaurant',),
                Tab(text: 'Cafe',),
                Tab(text: 'Pub',),
                Tab(text: 'Groceries',),
                Tab(text: 'Entertainment',),
                Tab(text: 'Fashion',),
              ],

              indicatorPadding: EdgeInsets.fromLTRB(0, 0, 0, 7.h),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              indicatorColor: Colors.green,
              unselectedLabelColor: Colors.grey[600],
              labelColor: Colors.black,
              unselectedLabelStyle: TextStyle(fontSize: 13.sp),
              labelStyle: TextStyle(
                  fontSize: 17.sp, fontWeight: FontWeight.w500),
            ),
          ),
          body: TabBarView(
            children: [
              RestaurantMyList(),
              CafeMyList(),
              PubMyList(),
              GroceryMyList(),
              EnterMyList(),
              FashionMyList(),
            ],
          )
      ),
    );
  }
}

