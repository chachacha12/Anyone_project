import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../Extend_HeroImage.dart';
import '../NaverMapDeepLink.dart';
import '../Provider/Provider.dart';
import '../authentic/login.dart';
import '../authentic/signup.dart';
import '../home/aroundcampus_content/entertainment/Entertainment_more.dart';
import '../various_widget.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

///엔터테인먼트 내 찜리스트
class EnterMyList extends StatefulWidget {
  const EnterMyList({Key? key}) : super(key: key);

  @override
  State<EnterMyList> createState() => _EnterMyListState();
}


class _EnterMyListState extends State<EnterMyList> {

  var entertainmentMyList; //내찜목록 컬렉션
  var count = 0;
  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  dynamic entertainment_document; //Entertainment_more에 보내줄 문서 하나

  @override
  void initState() {
    super.initState();
  }

  ///이 페이지 들어올때마다 계속 store에서 값 받아서 내 찜목록 업뎃해줌
  updateMyList(){
    setState(() {
      entertainmentMyList = context
          .read<MyListStore>()
          .entertainmentMyList;

      count = entertainmentMyList.length;
    });
    print('makeMyList실행,  entertainmentMyList: '+entertainmentMyList.toString());
  }

  ///찜목록을 정말 삭제할건지 확인차 띄워줄 다이얼로그
  makeDialog(index){
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
              TextButton(onPressed: ()  {
                  ///삭제로직 적어줌
                   deleteDoc(index);
                   Navigator.of(context).pop();
              },
                  child: Text('Yes', style: TextStyle(
                      color: Colors.green),)),
              TextButton(onPressed: () {
                Navigator.of(context).pop();
              },
                  child: Text('No', style: TextStyle(
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
          .collection('entertainment')
          .doc(
          entertainmentMyList[index]['title'])
          .delete();
      print('삭제성공');

      ///store에 찜목록 삭제로직
      context.read<MyListStore>()
          .deleteEntertainment(
          entertainmentMyList[index]);

      ///이 페이지의 state인 entertainmentMyList값 업뎃
      setState(() {
        entertainmentMyList = context
            .read<MyListStore>()
            .entertainmentMyList;

        count = entertainmentMyList.length;
      });

    } catch (e) {
      print('에러');
    }
  }


  @override
  Widget build(BuildContext context) {

    updateMyList();

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
                                        entertainmentMyList[index]['title'],
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
                                        icon: Icon(Icons.favorite),
                                        color: Colors.red,
                                        iconSize: 30,
                                        /// 파베 내 찜목록에서 제거
                                        onPressed: () async {
                                          ///정말 삭제할건지 다이얼로그 띄워주기
                                          makeDialog(index);
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
                                            titlename: entertainmentMyList[index]['title']),

                                        Text(
                                          entertainmentMyList[index]['category'
                                          ],
                                          style: TextStyle(
                                              fontSize: 15.sp
                                          ),),
                                        Container(
                                          //margin: EdgeInsets.fromLTRB(10.w, 0.h, 7.w, 0.h),
                                          child: richtext(Icon(
                                              Icons.access_time_outlined,
                                              size: 15.h),
                                              entertainmentMyList[index]['time']),
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
                                          entertainmentMyList[index];
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
                                  itemCount: entertainmentMyList[index]['imagepath']
                                      .length,
                                  itemBuilder: (context, index2) {
                                    return SizedBox(
                                      width: 150.0.w,
                                      child: Card(
                                        child: GestureDetector( //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                                          child: Hero(
                                            tag: entertainmentMyList[index]['imagepath'][index2],
                                            child: Image.network(
                                              entertainmentMyList[index]['imagepath'][index2],
                                              fit: BoxFit.cover,),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(
                                                builder: (context) =>
                                                    Extend_HeroImage(
                                                        entertainmentMyList[index]['imagepath'],
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
}
