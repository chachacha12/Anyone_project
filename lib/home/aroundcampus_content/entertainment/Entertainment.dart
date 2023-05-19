import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../../Extend_HeroImage.dart';
import '../../../NaverMapDeepLink.dart';
import '../../../Provider/Provider.dart';
import '../../../authentic/signup.dart';
import '../../../various_widget.dart';
import 'Entertainment_more.dart';
/*
찜목록리스트 로직:
1. 앱실행하자마자 파베에서 찜목록 리스트들 가져와서 store에 저장해줌 - provider manager에서.
2. 이 페이지 들어와서 새로운 찜을 추가하거나 삭제하면 store에만 doc_id를 추가하거나 삭제해주고 파베에는 추가, 삭제로직만 진행
 -> 이렇게 로직짜면 새로운 찜이 생기거나 삭제될때마다 파베에서 찜목록 다시 안가져오고 store에서만 참조하면 되므로.
*/
//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

class Entertainment extends StatefulWidget {
  Entertainment({Key? key}) : super(key: key);

  @override
  State<Entertainment> createState() => _EntertainmentState();
}


class _EntertainmentState extends State<Entertainment> with AutomaticKeepAliveClientMixin {
  var Entertainment_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var count = 0;
  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  dynamic entertainment_document; //Cafe_more에 보내줄 카페 컨텐츠 문서 하나
  var isMyList = []; //어떤 index의 컨텐츠가 찜한 컨텐츠인지 확인해서 색상아이콘 넣어주기 위함

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    //컨텐츠 보여주기 위해 가져오는 데이터들
    var result = await firestore.collection('entertainment').get();

    //내 찜목록 확인위해 가져오는 찜목록 데이터
    var result2 = await firestore.collection('MyList').doc(
        auth.currentUser?.uid).collection('entertainment').get();

    ///이렇게 해주는 이유는 유저가 새 컨텐츠를 찜 하거나 찜 삭제할때마다 파베에 접근해서 새로운 찜목록을 가져오지 않게 하기위함임.
    ///즉 파베에 추가, 삭제 로직만 작동하도록 해주고 ui상에선 이걸로 보여주기 위함임
    for (var doc in result2.docs) {
      context.read<MyListStore>().addEntertainment(
          doc['doc_id']); // store 찜목록리스트에 파베에서 가져온 doc_id 필드값들을 저장
    }
    setState(() {
      Entertainment_collection = result.docs; //컬랙션안의 문서리스트를 저장
      count = result.size; //컬랙션안의 문서갯수를 가져옴
    });

    makeMyList();
  }

  ///isMyList 리스트에 값을 채워주는 함수.  어떤 index의 컨텐츠가 찜한 컨텐츠인지 확인해서 찜한컨텐츠만 색아이콘 보여주고, 클릭시 실시간으로 아이콘 색 변경해주기 위한작업
  makeMyList(){
    // 전체 컨텐츠 문서 하나씩 확인
    print('@@@enter에서 모든 내찜문서들 도는 작업 진행');
    for (var doc in Entertainment_collection) {
      var exist = false;
      //내 찜목록 문서id들 하나씩 확인
      for (var docId in context
          .read<MyListStore>()
          .entertainmentMyList) {
        ///찜목록에 이미 존재
        if (doc?.id == docId) {
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


  ///파베에서 문서 삭제해주는 함수
  deleteDoc(index) async {
    try {
      await firestore.collection(
          'MyList')
          .doc(auth.currentUser?.uid)
          .collection('entertainment')
          .doc(
          Entertainment_collection[index]['title'])
          .delete();
      print('삭제성공');

      ///store에 새로운 찜목록 추가로직
      context.read<MyListStore>()
          .deleteEntertainment(
          Entertainment_collection[index]
              ?.id);
    } catch (e) {
      print('에러');
    }
  }
  ///파베에서 문서 추가해주는 함수
  addDoc(index) async {
    try {
      await firestore.collection(
          'MyList')
          .doc(auth.currentUser?.uid)
          .collection('entertainment')
          .doc(
          Entertainment_collection[index]['title'])
          .set({
        'doc_id': Entertainment_collection[index]
            ?.id
      });
      print('저장 성공');

      ///store에 새로운 찜목록 추가로직
      context.read<MyListStore>()
          .addEntertainment(
          Entertainment_collection[index]
              ?.id);
    } catch (e) {
      print('에러');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
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
                            Row( //가게명과 찜버튼
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 7,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          10.w, 0.h, 7.w, 0.h),
                                      child: Text(
                                        Entertainment_collection[index]['title'],
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    )
                                ),

                                Flexible(
                                  //fit: FlexFit.loose,
                                  flex: 1,
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0.w, 0.h, 0.w, 0.h),
                                      child: IconButton(
                                        icon: isMyList[index] ? Icon(
                                            Icons.favorite) : Icon(
                                            Icons.favorite_border),
                                        color: isMyList[index]
                                            ? Colors.red
                                            : Colors.black45,
                                        iconSize: 30,
                                        /// 파베 내 찜목록에 저장 or 제거
                                        onPressed: () async {
                                          ///이미 내찜목록에 이 컨텐츠가 존재할때 처리 - 파베에서 삭제 로직 진행 + store에서도 삭제
                                          if (isMyList[index]) {
                                            deleteDoc(index);
                                          } else {
                                            ///내 찜목록에 이 컨텐츠가 없을때 처리  - 파베에 찜목록 추가로직 진행 + store에도 추가
                                            addDoc(index);
                                          }
                                          ///아이콘 색상 바꾸기위함
                                          setState(() {
                                            isMyList[index] = !isMyList[index];
                                          });
                                        },
                                      )
                                  ),

                                )
                              ],
                            ),

                            /// 네이버맵, 카테고리, 시간 /  more버튼
                            Container(
                              margin: EdgeInsets.fromLTRB(10.w, 15.h, 0.w, 0.w),
                              child: Row(
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
                                            titlename: Entertainment_collection[index]['title']),

                                        Text(
                                          Entertainment_collection[index]['category'
                                          ],
                                          style: TextStyle(
                                              fontSize: 15.sp
                                          ),),
                                        Container(
                                          //margin: EdgeInsets.fromLTRB(10.w, 0.h, 7.w, 0.h),
                                          child: richtext(Icon(
                                              Icons.access_time_outlined,
                                              size: 15.h),
                                              Entertainment_collection[index]['time']),
                                        )
                                      ],
                                    ),
                                  ),

                                  ///more버튼
                                   Flexible(
                                      fit: FlexFit.tight,
                                      flex: 2,
                                      child: Container(
                                        //margin: EdgeInsets.fromLTRB(10.w, 0.h, 7.w, 0.h),
                                        child: OutlinedButton(onPressed: () {
                                          entertainment_document =
                                          Entertainment_collection[index];
                                          //페이지 이동
                                          Navigator.push(
                                              context, MaterialPageRoute(
                                              builder: (context) =>
                                                  Entertainment_more(
                                                      entertainment_document)));
                                        }, child: Text('more'),),
                                      )
                                  ),
                                ],
                              ),

                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(0.w, 5.h, 0.w, 0.w),
                              height: 150.0.h,
                              child: ListView.builder( //이미지들 수평리스트로 보여줌
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Entertainment_collection[index]['imagepath']
                                      .length,
                                  itemBuilder: (context, index2) {
                                    return SizedBox(
                                      width: 150.0.w,
                                      child: Card(
                                        child: GestureDetector( //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                                          child: Hero(
                                            tag: Entertainment_collection[index]['imagepath'][index2],
                                            child: Image.network(
                                              Entertainment_collection[index]['imagepath'][index2],
                                              fit: BoxFit.cover,),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(
                                                builder: (context) =>
                                                    Extend_HeroImage(
                                                        Entertainment_collection[index]['imagepath'],
                                                        index2)));
                                          },
                                        ),
                                      ),
                                    );
                                  }),
                            ),
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
