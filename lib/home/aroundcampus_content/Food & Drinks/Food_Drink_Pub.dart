import 'package:anyone/home/aroundcampus_content/Food%20&%20Drinks/restaurant/Restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../loading/shimmerloadinglist.dart';
import 'cafe/Cafe_more.dart';


//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

class FoodDrinkPub extends StatefulWidget {
  const FoodDrinkPub({Key? key}) : super(key: key);

  @override
  State<FoodDrinkPub> createState() => _FoodDrinkPubState();
}

class _FoodDrinkPubState extends State<FoodDrinkPub> with AutomaticKeepAliveClientMixin {
  late bool _isLoading = false; //늦은 초기화 해줌
  var restaurant_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var count = 0;
  var show_restaurant_num = 6; //수평리스트에서 보여줄 음식점 사진 갯수
  var restaurant_random_list = []; //db에 있는 식당의 갯수에 맞춰서 0부터 n까지 값을 랜덤하게 저장해둘 리스트


  getData() async {
    print('푸드 & 드링크 getData실행됨 @@@');
    _isLoading = true; //여기서 로딩변수 초기화
    var result = await firestore.collection('restaurant').get();
    setState(() {
      _isLoading = false; //데이터받기 끝나면 로딩화면 꺼줌
      restaurant_collection = result.docs; //컬랙션안의 문서리스트를 저장
      count = result.size; //컬랙션안의 문서갯수를 가져옴
    });

    //식당 문서들 갯수만큼의 값을 갖는 리스트를 만들어준 후 숫자를 랜덤하게 섞어둘거임
    for (int i = 0; i < count; i++) {
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
    return CustomScrollView(
      slivers: [

        SliverToBoxAdapter(
          child: Container(
           // height: 600.h,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(20.w, 30.h, 10.w, 0.h),
                  child: Row(
                    children: [
                      Container(
                        width: 170.h,
                        padding: EdgeInsets.all(10.w),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(topLeft:Radius.circular(20), bottomLeft:Radius.circular(20)),
                          gradient: LinearGradient(
                            colors: [
                              Colors.green[500]!,
                              Colors.green[400]!,
                              Colors.green[400]!,
                              Colors.green[300]!,
                              Colors.green[200]!,
                              Colors.green[100]!,
                              Colors.green[50]!,
                            ],
                          ),
                        ),
                        child: Text('Local Restaurant',
                            style: TextStyle(fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w500)),
                      ),
                      Text(' 🍔', style: TextStyle(fontSize: 33.sp)),

                      Expanded(child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(onPressed: () { //식당정보 더 보기 버튼
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                //카페와 식당 db의 필드가 같아서 카페에서 갔다씀
                                Restaurant()));
                          }, child: Row(
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0.w, 0.w, 0.w, 1.h),
                                child: Text('view all', textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    0.w, 0.w, 0.w, 0.h),
                                child: Icon(Icons.chevron_right, size: 18.sp,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),

                ///3번째 - 데이터요청 안끝났으면 로딩화면 보여주고있을거임
                _isLoading ? ShimmerLoadingList() :
                Container(
                  margin: EdgeInsets.fromLTRB(10.w, 5.h, 0.w, 0.w),
                  height: 150.0.h,
                  child: ListView.builder( //이미지들 수평리스트로 보여줌
                      scrollDirection: Axis.horizontal,
                      itemCount: show_restaurant_num,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 150.0.w,
                          //height: 150.0.h,
                          child: Card(
                            child: GestureDetector( //클릭시 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                              child: Stack( //이미지와 텍스트를 겹치게 할때 주로 사용
                                fit: StackFit.expand,
                                children: [
                                  Hero(
                                    tag: restaurant_collection[restaurant_random_list[index]]['imagepath'][0],
                                    //랜덤리스트의 0번째 인덱스값부터 넣음- 랜덤하게 보여줌
                                    child: Image.network(
                                      restaurant_collection[restaurant_random_list[index]]['imagepath'][0],
                                      fit: BoxFit.cover,),
                                  ),
                                  Positioned(child: Text(' '+
                                      restaurant_collection[restaurant_random_list[index]]['name'],
                                    maxLines: 2,
                                    style: TextStyle(color: Colors.white,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold),),

                                    bottom: 3.h,)
                                ],
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                    //카페와 식당 db의 필드가 같아서 카페에서 갔다씀
                                    Cafe_more(
                                        restaurant_collection[restaurant_random_list[index]])));
                              },
                            ),
                          ),
                        );
                      }),
                ),

              ],
            ),
          ),
        )

      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
