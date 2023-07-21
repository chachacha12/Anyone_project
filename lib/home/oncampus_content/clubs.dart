import 'package:anyone/loading/shimmercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../various_widget.dart';

//파베 파이어스토어 사용을 위한 객체
final firestore = FirebaseFirestore.instance;


class Clubs extends StatefulWidget {
  const Clubs({Key? key}) : super(key: key);

  @override
  State<Clubs> createState() => _ClubsState();
}

class _ClubsState extends State<Clubs> {

  var clubs_collection;  //파이어스토어로부터 받아올 문서들 리스트를 여기에 넣어줄거임
  var count=0;
  late bool _isLoading = false; //데이터 가져올때 늦은 초기화 해줌

  getData() async {
    _isLoading = true;
    var result = await firestore.collection('clubs').get();

    setState(() {
      clubs_collection = result.docs;   //컬랙션안의 문서리스트를 저장
      count = result.size;  //컬랙션안의 문서갯수를 가져옴
    });

    //몇초뒤에 동작 수행하도록 함
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
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
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            'Clubs', style: onCampusAppBarStyle(),
          ),
          ),

          //contactus와 애니원메일버튼, schoolcontact. 즉 3개 박스 들어감
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('How to join?', style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp
                    )),
                    Card(
                      elevation: 1,
                      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0.h),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "\n"'● Application procedure is all depending on each clubs’ rule.'"\n\n"
                            '● You should directly ask to a president of a club, asking specific timeline & activities.'"\n"
                            '(Usually recruiting starts during the first month of a new semester)'"\n\n"
                            '● Looking around the lists we’ve provided below and try to ask if you could join !'"\n",
                            style: TextStyle(
                              fontSize: 15.sp
                            )),
                      )
                    ),

                    Text("\n"'List', style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp
                    )),
                  ],
                ),
              ),
            ),
          ),

          //동아리 보여주는 리스트
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>

                    _isLoading? ShimmerCard4() :
                    Container(
                      color: Colors.white,
                      child: Card(        //리스트 속 각각의 객체 하나하나임
                        elevation: 1,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),

                        child: ListTile(
                          title: Text(clubs_collection[index]['name'], style: Theme.of(context).textTheme.titleMedium),
                          subtitle: Text(clubs_collection[index]['english'], ),
                          trailing: Text(clubs_collection[index]['contact']),
                          onTap: ()  {
                            //_makePhoneCall(contact_list[index][1]);
                          },
                        ),
                      ),
                    ),
                childCount: count),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 60.h,
            ),
          )
        ],
      ),
    );
  }
}


