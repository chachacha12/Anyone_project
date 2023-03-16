import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Extend_HeroImage.dart';
import '../../../NaverMapDeepLink.dart';
import '../../../various_widget.dart';
import 'Pub_more.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;


class Pub extends StatefulWidget {
  Pub({Key? key}) : super(key: key);

  @override
  State<Pub> createState() => _PubState();
}


class _PubState extends State<Pub> {

  var Pub_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var count = 0;
  var imgList = []; //이미지들 주소 string값을 저장해줄 리스트
  dynamic pub_document; //Cafe_more에 보내줄 카페 컨텐츠 문서 하나

  getData() async {
    var result = await firestore.collection('pub').get();

    setState(() {
      Pub_collection = result.docs; //컬랙션안의 문서리스트를 저장
      count = result.size; //컬랙션안의 문서갯수를 가져옴
    });

    //부가설명해주는 텍스트 - 줄바꿈이 파베 firestore에선 되지않아서 여기서 줄바꿈을 해준후 보여주기위함.
    var text = Pub_collection['text'].toString().replaceAll("\\n", "\n");
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 240.0.h,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('Recommended by\nLocal KU students',
                textAlign: TextAlign.center, style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),),
              background: Image.asset(
                'assets/Pub/pub_background.jpg',
                fit: BoxFit.cover,),
            ),
          ),

          //술집가게 리스트 보여줌
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>

                    Container( //컨텐츠 하나하나
                        margin: EdgeInsets.symmetric(
                            vertical: 20.h, horizontal: 10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row( //가게명과 물음표 상세보기 버튼
                              children: [
                                Flexible(
                                    fit: FlexFit.tight,
                                    flex: 4,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 0.h),
                                      child: Text(
                                          Pub_collection[index]['name'],
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold
                                        ),),
                                    )
                                ),
                                Flexible(
                                  flex: 1,
                                  child: OutlinedButton(onPressed: () {
                                    pub_document = Pub_collection[index];
                                    //페이지 이동
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) =>
                                            Pub_more(pub_document)));
                                  }, child: Text('more'),),
                                )
                              ],
                            ),

                            Container(
                              width: double.infinity,
                                margin: EdgeInsets.fromLTRB(
                                    10.w, 0.h, 10.w, 0.w),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //네이버맵 url scheme값을 이용해서 딥링크 연결하는 동작을 위한 커스텀위젯
                                    //인자값으로 각 컨텐츠의 풀네임값을 보내줌
                                    NaverMapDeepLink( titlename : Pub_collection[index]['name'] ),

                                    Text(Pub_collection[index]['tag'
                                    ],
                                      style: TextStyle(
                                          fontSize: 15.sp
                                      ),),
                                    richtext(Icon(
                                        Icons.monetization_on_outlined,
                                        size: 15.h),
                                        Pub_collection[index]['price']),
                                  ],
                                )
                            ),

                            Container(
                              margin: EdgeInsets.fromLTRB(0.w, 5.h, 0.w, 0.w),
                              height: 150.0.h,
                              child: ListView.builder( //이미지들 수평리스트로 보여줌
                                  scrollDirection: Axis.horizontal,
                                  itemCount: Pub_collection[index]['imagepath']
                                      .length,
                                  itemBuilder: (context, index2) {
                                    return SizedBox(
                                      width: 150.0.w,
                                      child: Card(
                                        child: GestureDetector( //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                                          child: Hero(
                                            tag: Pub_collection[index]['imagepath'][index2],
                                            child: Image.network(
                                              Pub_collection[index]['imagepath'][index2],
                                              fit: BoxFit.cover,),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(
                                                builder: (context) =>
                                                    Extend_HeroImage(
                                                        Pub_collection[index]['imagepath'][index2])));
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

