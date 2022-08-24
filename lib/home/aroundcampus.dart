import 'package:anyone/home/aroundcampus_content/cafe/Cafe_more.dart';
import 'package:anyone/home/aroundcampus_content/discount/Discount.dart';
import 'package:anyone/home/aroundcampus_content/entertainment/Entertainment.dart';
import 'package:anyone/home/aroundcampus_content/fashion/Fashion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'aroundcampus_content/cafe/Cafe.dart';
import 'aroundcampus_content/culture/Culture.dart';
import 'aroundcampus_content/fashion/Fashion_hero_image.dart';
import 'aroundcampus_content/groceryshop/GroceryShop.dart';
import 'aroundcampus_content/pub/Pub.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import 'aroundcampus_content/restaurant/Restaurant.dart';


//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;


//around-campus 관련 정보들을 다 담고있는 박스위젯 + 식당 컬렉션 문서들을 다 가져와서 보여줌
class AroundCampus extends StatefulWidget {
  const AroundCampus({Key? key}) : super(key: key);

  @override
  State<AroundCampus> createState() => _AroundCampusState();
}

//AutomaticKeepAliveClientMixin 덕분에 식당데이터 가져온것들 oncampus탭으로 갔다올때마다 다시 요청하지 않고 상태유지함
class _AroundCampusState extends State<AroundCampus> with AutomaticKeepAliveClientMixin {

  var restaurant_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var count = 0;
  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  var show_restaurant_num=6;  //수평리스트에서 보여줄 음식점 사진 갯수
  var restaurant_random_list = []; //db에 있는 식당의 갯수에 맞춰서 0부터 n까지 값을 랜덤하게 저장해둘 리스트
  var i=0;


  getData() async {
    var result = await firestore.collection('restaurant').get();

    setState(() {
      restaurant_collection = result.docs; //컬랙션안의 문서리스트를 저장
      count = result.size; //컬랙션안의 문서갯수를 가져옴
    });

    //식당 문서들 갯수만큼의 값을 갖는 리스트를 만들어준 후 숫자를 랜덤하게 섞어둘거임
    for(int i=0; i<count; i++){
      restaurant_random_list.add(i);
    }
    restaurant_random_list.shuffle(); //리스트를 랜덤하게 섞어줌

  }

  @override
  void initState() {
    super.initState();
    getData();
  }

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
                              MaterialPageRoute(builder: (context) => Cafe()  ) //식당정보더보기도 이 Cafe()커스텀위젯 쓸거라, 컬렉션 네임 각각 보내줌
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Culture() )
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
                            title: Text('Entertainment', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black
                                )),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Entertainment() )
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
                            title: Text('Discount', textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black
                                )),
                          ),
                        ),
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                              //카페와 식당 db의 필드가 같아서 카페에서 갔다씀
                              Discount()   ));

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
                              ElevatedButton(onPressed: () {              //식당정보 더 보기 버튼
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                    //카페와 식당 db의 필드가 같아서 카페에서 갔다씀
                                    Restaurant()   ));

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
                margin: EdgeInsets.fromLTRB(0.w, 5.h, 0.w, 0.w),
                height: 150.0.h,
                child: ListView.builder( //이미지들 수평리스트로 보여줌
                    scrollDirection: Axis.horizontal,
                    itemCount: show_restaurant_num,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 150.0.w,
                        child: Card(
                          child: GestureDetector(   //클릭시 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                            child: Stack(  //이미지와 텍스트를 겹치게 할때 주로 사용
                              fit: StackFit.expand,
                              children: [
                                Hero(
                                  tag: restaurant_collection[restaurant_random_list[index]]['imagepath'][0],  //랜덤리스트의 0번째 인덱스값부터 넣음- 랜덤하게 보여줌
                                  child: Image.network(
                                    restaurant_collection[restaurant_random_list[index]]['imagepath'][0],
                                    fit: BoxFit.cover,),
                                ),
                                Positioned(child: Text(restaurant_collection[restaurant_random_list[index]]['name'],
                                style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.bold),),
                                bottom: 3.h,)
                              ],
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                  //카페와 식당 db의 필드가 같아서 카페에서 갔다씀
                                  Cafe_more(restaurant_collection[restaurant_random_list[index]] )  ));
                            },
                          ),
                        ),
                      );
                    }),
              ),
            ),

          ],
        ));
  }

  @override
  bool get wantKeepAlive => true;
}

