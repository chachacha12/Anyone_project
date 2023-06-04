import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../NaverMapDeepLink.dart';
import '../../Provider/Provider.dart';
import '../../authentic/signup.dart';
import '../../home/aroundcampus_content/CommonWidget.dart';
import '../../home/aroundcampus_content/Food & Drinks/cafe/Cafe_more.dart';
import '../../home/aroundcampus_content/entertainment/Entertainment_more.dart';
import '../../various_widget.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

///내 찜리스트
class RestaurantMyList extends StatefulWidget {
  const RestaurantMyList({Key? key}) : super(key: key);

  @override
  State<RestaurantMyList> createState() => _RestaurantMyListState();
}


class _RestaurantMyListState extends State<RestaurantMyList> {
  var restaurantMyList; //내찜목록 컬렉션
  var count = 0;
  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  late bool exists; // 찜목록이 존재하는지 확인

  @override
  void initState() {
    super.initState();
  }

  ///이 페이지 들어올때마다 계속 store에서 값 받아서 내 찜목록 업뎃해줌
  updateMyList() {
    setState(() {
      restaurantMyList = context
          .read<MyListStore>()
          .restaurantMyList;
      if(restaurantMyList != null){
        count = restaurantMyList?.length;
      }
      if (count == 0) {
        exists = false;
      } else {
        exists = true;
      }
    });
  }

  ///찜목록을 정말 삭제할건지 확인차 띄워줄 다이얼로그
  makeDialog(index) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text('Are you sure you want to delete it?',
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15.sp
          ),),
        actions: [
          Row(mainAxisAlignment: MainAxisAlignment
              .spaceAround,
            children: [
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              },
                  child: Text('No', style: TextStyle(
                      color: Colors.green),)),
              TextButton(onPressed: () {
                ///삭제로직 적어줌
                deleteDoc(index);
                Navigator.of(context).pop();
              },
                  child: Text('Yes', style: TextStyle(
                      color: Colors.green),)),
            ],)
        ],
      );
    });
  }

  ///파베의 내찜리스트에서 문서 삭제해주는 함수
  deleteDoc(index) async {
    try {
      await firestore.collection(
          'MyList')
          .doc(auth.currentUser?.uid)
          .collection('restaurant')
          .doc(
          restaurantMyList[index]['name'])
          .delete();
      print('삭제성공');

      ///store에 찜목록 삭제로직
      context.read<MyListStore>()
          .deleteRestaurant(
          restaurantMyList[index]);

      ///state도 업뎃
      setState(() {
        restaurantMyList = context
            .read<MyListStore>()
            .restaurantMyList;

        count = restaurantMyList.length;
      });
    } catch (e) {
      print('에러');
    }
  }


  @override
  Widget build(BuildContext context) {
    updateMyList();

    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
        ///찜목록이 하나라도 존재할 경우엔 리스트를 보여줌
        body: exists ? CustomScrollView(
          slivers: [
            //리스트 보여줌
            SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                      Container( //컨텐츠 하나하나
                          margin: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(

                                ///가게명과 찜버튼
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    fit: FlexFit.tight,
                                    flex: 7,
                                    child: contentsName(
                                        restaurantMyList[index]['name']), //CommonWidget파일안에 있는 함수
                                  ),

                                  ///찜버튼
                                  Flexible(
                                    //fit: FlexFit.loose,
                                    flex: 1,
                                    child: GestureDetector(
                                        child: myListButton(true),
                                        onTap: () async {
                                          ///정말 삭제할건지 다이얼로그 띄워주기
                                          makeDialog(index);
                                        }
                                    ),
                                  )
                                ],
                              ),

                              /// 네이버맵, 카테고리, 시간 /  more버튼
                              Container(
                                margin: EdgeInsets.fromLTRB(
                                    10.w, 15.h, 0.w, 0.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      fit: FlexFit.tight,
                                      flex: 7,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceAround,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          //네이버맵 url scheme값을 이용해서 딥링크 연결하는 동작을 위한 커스텀위젯
                                          //인자값으로 각 컨텐츠의 풀네임값을 보내줌
                                          NaverMapDeepLink(
                                              titlename: restaurantMyList[index]['name']),

                                          Text(
                                            restaurantMyList[index]['tag'
                                            ],
                                            style: TextStyle(
                                                color: Color(0xff706F6F),
                                                fontSize: 14.sp
                                            ),),
                                          Container(
                                            //margin: EdgeInsets.fromLTRB(10.w, 0.h, 7.w, 0.h),
                                            child: richtext(Icon(
                                                Icons.monetization_on_outlined,
                                                color: Color(0xff706F6F),
                                                size: 14.h),
                                                restaurantMyList[index]['price']),
                                          )
                                        ],
                                      ),
                                    ),

                                    ///view more버튼
                                    Flexible(
                                        fit: FlexFit.tight,
                                        flex: 3,
                                        child: TextButton(
                                            onPressed: () { //식당정보 더 보기 버튼
                                              //페이지 이동
                                              Navigator.push(
                                                  context, MaterialPageRoute(
                                                  builder: (context) =>
                                                      Cafe_more(
                                                          restaurantMyList[index])));
                                            }, child: moreButton()
                                        )
                                    ),
                                  ],
                                ),

                              ),

                              ///문서하나의 이미지들 수평리스트로 띄워주는 함수 - CommonWidget파일안에
                              getImageList(restaurantMyList[index]),

                            ],
                          )
                      ),
                  childCount: count),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 40.h,
              ),
            ),
          ],
        ) :

       ///목록이 아무것도 없을경우엔 해당 박스 보여줌 - CommonWidget안에 있음
        getEmptyList()
    );
  }
}










