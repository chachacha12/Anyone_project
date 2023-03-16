import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Extend_HeroImage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;

//academic calender를 보려고 클릭시 띄워줄 커스텀 위젯.  이미지 2개 보여줄거임
class Calender extends StatefulWidget {
   Calender({Key? key}) : super(key: key);

  @override
  State<Calender> createState() => _CalenderState();
}


class _CalenderState extends State<Calender> {

  late bool _isLoading = false; //늦은 초기화 해줌
  var calender_collection; //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임

  getData() async {
    _isLoading = true; //여기서 로딩변수 초기화
    var result = await firestore.collection('academic calender').get();

    setState(() {
      _isLoading = false; //데이터받기 끝나면 로딩화면 꺼줌
      calender_collection = result.docs; //컬랙션안의 문서리스트를 저장
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  //collapsedHeight: 50.h,
                  title: Text('Academic Calender'),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'Official Ver',),
                      Tab(text: 'OIA Ver',)
                    ],
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorWeight: 2,
                    indicatorColor: Colors.green,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                    labelStyle: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w500),

                  ),
                ),
              ];
            },
            body:

            ///데이터요청 안끝남 -> 로딩화면  / 끝남 -> calender 이미지
            _isLoading ? Center(child: SpinKitFadingCircle(color: Colors.green, size: 60.0.r,)) :
            Container(
              color: Colors.white,
              child: TabBarView(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(5.w),
                    child: GestureDetector( //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                      child: Hero(
                        tag: calender_collection[0]['official ver'],
                        child: Image.network(
                            calender_collection[0]['official ver'],
                            fit: BoxFit.contain),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                Extend_HeroImage(
                                    calender_collection[0]['official ver'])));
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.all(5.w),
                    child: GestureDetector( //클릭시 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                      child: Hero(
                        tag: calender_collection[0]['OIA ver'],
                        child: Image.network(
                            calender_collection[0]['OIA ver'],
                            fit: BoxFit.contain),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) =>
                                Extend_HeroImage(
                                    calender_collection[0]['OIA ver'])));
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
