import 'package:anyone/home/aroundcampus_content/fashion/Fashion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

import 'aroundcampus_content/cafe/Cafe.dart';
import 'aroundcampus_content/groceryshop/GroceryShop.dart';
import 'aroundcampus_content/pub/Pub.dart';


//around-campus 관련 정보들을 다 담고있는 박스위젯
class AroundCampus extends StatefulWidget {
  const AroundCampus({Key? key}) : super(key: key);

  @override
  State<AroundCampus> createState() => _AroundCampusState();
}

class _AroundCampusState extends State<AroundCampus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            //아이콘들 보여줌
            SliverToBoxAdapter(
              child: Container(
                height: 300.0.h,
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(0.h),
                      child: GestureDetector(
                        child: GridTile(
                          child: Icon(Icons.star),
                          footer: GridTileBar(
                            title: Text('Grocery'"\n"'shopping',
                                textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.black
                                )),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => GroceryShop() )
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(0.h),
                      child: GestureDetector(
                        child: GridTile(
                          child: Icon(Icons.star),
                          footer: GridTileBar(
                            title: Text('Fashion'"\n"'&beauty',
                                textAlign: TextAlign.center, style: TextStyle(
                                    color: Colors.black
                                )),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Fashion() )
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(0.h),
                      child: GestureDetector(
                        child: GridTile(
                          child: Icon(Icons.star),
                          footer: GridTileBar(
                            title: Text('cafe', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black
                                )),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Cafe() )
                          );
                        },
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(0.h),
                      child: GestureDetector(
                        child: GridTile(
                          child: Icon(Icons.star),
                          footer: GridTileBar(
                            title: Text('pub', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black
                                )),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Pub() )
                          );

                        },
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(0.h),
                      child: GestureDetector(
                        child: GridTile(
                          child: Icon(Icons.star),
                          footer: GridTileBar(
                            title: Text('Culture', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black
                                )),
                          ),
                        ),
                        onTap: (){

                        },
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(0.h),
                      child: GestureDetector(
                        child: GridTile(
                          child: Icon(Icons.star),
                          footer: GridTileBar(
                            title: Text('Entertainment', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black
                                )),
                          ),
                        ),
                        onTap: (){

                        },
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(0.h),
                      child: GestureDetector(
                        child: GridTile(
                          child: Icon(Icons.star),
                          footer: GridTileBar(
                            title: Text('Discount', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black
                                )),
                          ),
                        ),
                        onTap: (){

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                  height: 80.0.h,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Row(
                      children: [
                        Text('KU students'"'"''"\n"'go-to Restaurant',
                            style: TextStyle(fontSize: 20.sp)),
                        Text(' 🍔', style: TextStyle(fontSize: 35.sp)),
                        Expanded(child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(onPressed: () {

                              }, child: Text('more'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    onPrimary: Colors.white),
                              ),
                            ],
                          ),
                        ))

                      ],
                    ),
                  )
              ),
            ),

            //맛집목록들 수평리스트로 보여줌
            SliverToBoxAdapter(
              child: Container(
                height: 150.0.h,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150.0.w,
                        child: Card(
                          child: Text('data'),
                        ),
                      );
                    }),
              ),
            ),

          ],
        ));
  }
}

