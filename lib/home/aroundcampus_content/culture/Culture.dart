import 'package:anyone/loading/shimmercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../CommonWidget.dart';
import 'Culture_hero_second.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;


class Culture extends StatefulWidget {
  Culture({Key? key}) : super(key: key);

  @override
  State<Culture> createState() => _CultureState();
}

class _CultureState extends State<Culture> with AutomaticKeepAliveClientMixin{

  var culture_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var count = 0;
  late bool _isLoading = false; //늦은 초기화 해줌

  //hero위젯을 통해 전환될 페이지로 보내줄 팁컨텐츠 문서 하나임. 타입을 dynamic으로해야 어떤 타입이든 받을 수 있어서 이렇게함
  dynamic culture_document;

  getData() async {
    _isLoading = true; //여기서 로딩변수 초기화

    var result = await firestore.collection('culture').get();

    setState(() {
      culture_collection = result.docs; //컬랙션안의 문서리스트를 저장
      count = result.size; //컬랙션안의 문서갯수를 가져옴
      //_isLoading = false; //로딩화면 지워줌
    });

    //몇초뒤에 동작 수행하도록 함
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        _isLoading = false; //로딩화면 지워줌
      });
    });

  }

  @override
  void initState() {
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [

          //리스트 보여줌
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    _isLoading ? ShimmerCard3() :
                    Container(
                      color: Colors.white,
                      child: Container( //컨텐츠 하나하나
                          margin: EdgeInsets.symmetric(
                              vertical: 20.h, horizontal: 10.w),
                          child: GestureDetector(
                            child: Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: Hero(
                                      tag: culture_collection[index]['title'],
                                      child: Image.network(
                                          culture_collection[index]['imagepath'],
                                      fit: BoxFit.cover,),
                                    ),
                                    height: 250.h,
                                    //width: 150.h,
                                  ),
                                  //Spacer(flex: 2,),
                                  Card(
                                    elevation: 0.h,
                                    margin: EdgeInsets.fromLTRB(0.h, 5.h, 0.h, 5.h),
                                    child: contentsName(   culture_collection[index]['title']),
                                  ),
                           /*
                                  Card(
                                    elevation: 0.h,
                                    margin: EdgeInsets.fromLTRB(0.h, 0.h, 0.h, 5.h),
                                    child: Text(culture_collection[index]['tag'],
                                        textAlign: TextAlign.center,
                                        style:TextStyle(
                                            color: Color(0xff706F6F),
                                            fontSize: 13.sp
                                        )
                                    ),       //Text(tips_collection[index]['tag']
                                  ),
                            */

                                ],
                              ),
                            ),
                            onTap: () {             //누르면 히어로위젯 작동하며 페이지이동
                              culture_document =
                              culture_collection[index]; //선택한 팁 컨텐츠 문서하나를 전환될 페이지에 보내주기위해 저장
                              //이미지사진 클릭했을시 hero위젯을 통해 페이지전환 / 선택한 컨텐츠 문서 하나 전체를 두번째 페이지에 보내줌
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => Culture_hero_second(culture_document)));
                            },
                          ),
                      ),
                    ),
                childCount: count),
          ),





        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
