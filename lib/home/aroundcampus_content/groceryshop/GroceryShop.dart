import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../NaverMapDeepLink.dart';
import '../../../Provider/Provider.dart';
import '../../../authentic/signup.dart';
import '../../../various_widget.dart';
import '../CommonWidget.dart';
import 'GroceryShop_hero_second.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

//마트, 식료품점 정보
class GroceryShop extends StatefulWidget {
  const GroceryShop({Key? key}) : super(key: key);

  @override
  State<GroceryShop> createState() => _GroceryShopState();
}

class _GroceryShopState extends State<GroceryShop> with AutomaticKeepAliveClientMixin {
  var grocery_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var count = 0;
  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  var isMyList = []; //어떤 index의 컨텐츠가 찜한 컨텐츠인지 확인해서 색상아이콘 넣어주기 위함

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    //컨텐츠 보여주기 위해 가져오는 데이터들
    var result = await firestore.collection('grocery').get();

    setState(() {
      grocery_collection = result.docs; //컬랙션안의 문서리스트를 저장
      count = result.size; //컬랙션안의 문서갯수를 가져옴
    });
    makeMyList();
  }


  ///isMyList 리스트에 값을 채워주는 함수.  어떤 index의 컨텐츠가 찜한 컨텐츠인지 확인해서 찜한컨텐츠만 색아이콘 보여주고, 클릭시 실시간으로 아이콘 색 변경해주기 위한작업
  makeMyList(){
    if(grocery_collection!=null){
      isMyList.clear();
      // 전체 컨텐츠 문서 하나씩 확인
      for (var doc in grocery_collection) {
        var exist = false;
        //내 찜목록 문서들 하나씩 확인
        for (var myDoc in context
            .read<MyListStore>()
            .fashionMyList) {
          ///찜목록에 이미 존재
          if (doc['name'] == myDoc['name']) {
            exist = true;
            isMyList.add(true);
            break;
          }
        }
        ///찜목록에 없음
        if (!exist) {
          isMyList.add(false);
        }
      }
    }
  }


  ///파베의 내찜리스트에서 문서 삭제해주는 함수
  deleteDoc(index) async {
    try {
      await firestore.collection(
          'MyList')
          .doc(auth.currentUser?.uid)
          .collection('groceries')
          .doc(
          grocery_collection[index]['name'])
          .delete();
      print('삭제성공');

      ///store에 찜목록 삭제로직
      context.read<MyListStore>()
          .deleteGroceries(
          grocery_collection[index]);

    } catch (e) {
      print('에러');
    }
  }
  ///파베의 내찜리스트에 문서 추가해주는 함수
  addDoc(index) async {
    try {
      await firestore.collection(
          'MyList')
          .doc(auth.currentUser?.uid)
          .collection('groceries')
          .doc(
          grocery_collection[index]['name'])
          .set({
        'name': grocery_collection[index]['name'],
        'time': grocery_collection[index]['time'],
        'imagepath': grocery_collection[index]['imagepath'],
        'text': grocery_collection[index]['text'],
        'address': grocery_collection[index]['address'],
        'holiday': grocery_collection[index]['holiday'],
      });
      print('저장 성공');

      ///store에 새로운 찜목록 추가로직
      context.read<MyListStore>()
          .addGroceries(
          grocery_collection[index]);
    } catch (e) {
      print('에러');
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [


          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>

                        Container( //컨텐츠 하나하나
                            margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Row( ///가게명과 찜버튼
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///가게명
                                    Flexible(
                                        fit: FlexFit.tight,
                                        flex: 7,
                                        child: contentsName( grocery_collection[index]['name']) ///CommonWidget파일안에 있는 함수
                                    ),

                                    ///찜버튼
                                    Flexible(
                                      //fit: FlexFit.loose,
                                      flex: 1,
                                      child: GestureDetector(
                                          child: myListButton(isMyList[index]), ///CommonWidget파일안에 있는 함수
                                          onTap: () async {
                                            ///이미 내찜목록에 이 컨텐츠가 존재할때 처리 - 파베에서 삭제 로직 진행 + store에서도 삭제
                                            if (isMyList[index]) {
                                              ///아이콘 색상 바꾸기위함
                                              setState(() {
                                                isMyList[index] = !isMyList[index];
                                              });
                                              deleteDoc(index);
                                            } else {
                                              ///아이콘 색상 바꾸기위함
                                              setState(() {
                                                isMyList[index] = !isMyList[index];
                                              });
                                              ///내 찜목록에 이 컨텐츠가 없을때 처리  - 파베에 찜목록 추가로직 진행 + store에도 추가
                                              addDoc(index);
                                            }
                                          }
                                      ),
                                    )
                                  ],
                                ),


                                /// 네이버맵, 태그 /  more버튼
                                Container(
                                  margin: EdgeInsets.fromLTRB(10.w, 15.h, 0.w, 0.w),
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
                                                titlename: grocery_collection[index]['name']),

                                            Container(
                                              //margin: EdgeInsets.fromLTRB(10.w, 0.h, 7.w, 0.h),
                                              child: richtext(Icon(
                                                  Icons.location_on_outlined,
                                                  color:  Color(0xff706F6F),
                                                  size: 14.h),
                                                grocery_collection[index]['address'
                                                ],),
                                            ),

                                            Container(
                                              //margin: EdgeInsets.fromLTRB(10.w, 0.h, 7.w, 0.h),
                                              child: richtext(Icon(
                                                  Icons.access_time_outlined,
                                                  color:  Color(0xff706F6F),
                                                  size: 14.h),
                                                  grocery_collection[index]['time']),
                                            )
                                          ],
                                        ),
                                      ),

                                      ///view more버튼
                                      Flexible(
                                          fit: FlexFit.tight,
                                          flex: 3,
                                          child: TextButton(onPressed: () { //식당정보 더 보기 버튼

                                            //페이지 이동
                                            Navigator.push(
                                                context, MaterialPageRoute(
                                                builder: (context) =>
                                                    GroceryShop_hero_second(
                                                        grocery_collection[index])));
                                          }, child: moreButton(), ///CommonWidget파일안에 있는 view more버튼
                                          )
                                      ),
                                    ],
                                  ),
                                ),

                                ///문서하나의 이미지들 수평리스트로 띄워주는 함수 - CommonWidget파일안에
                                getImageList(grocery_collection[index]),
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
      ),

    );
  }

  //이 페이지 상태유지를 위한 함수
  @override
  bool get wantKeepAlive => true;
}



