import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Keep extends StatelessWidget {
  const Keep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            title: Text('My List', style: TextStyle(color: Colors.black)),
           // toolbarHeight: 20.h, ///탭바의 전체적인 길이를 조절
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Food & Drinks',),
                Tab(text: 'Groceries',),
                Tab(text: 'Entertainment',),
                Tab(text: 'Fashion',),
                Tab(text: 'Culture',)
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

              //FoodDrinkPub(),
              //GroceryShop(),
              //Entertainment(),
              //Fashion(),
              //Culture(),
            ],
          )
      ),
    );
  }
}
