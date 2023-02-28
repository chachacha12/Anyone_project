import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentic/login.dart';
import '../authentic/signup.dart';
import '../main.dart';
import 'package:intl/intl.dart';

//회원가입 및 로그인한 유저의 정보를 보여주는 페이지
class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {

  //sharedpref에 유저 떠나는 날짜 저장하기
  saveData(departureDate) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString('departure_date', departureDate);
  }

  //sharedpref에 유저가 저장해둔 떠나는 날짜 가져오기 - initState()에서 실행
  getData() async {
    var storage = await SharedPreferences.getInstance();
    var departure_date = storage.getString('departure_date');
    if(departure_date != null){  //저장된 날짜값이 있다면
      Dday_calculating(departure_date); //디데이를 계산하고 값을 변경해줌
    }
  }

  //디데이값을 계산해주는 메소드
  Dday_calculating(departure_date){

    var formatter = DateFormat('yyyy-MM-dd');
    //받아온 string날짜값인 departure_date를 Date타입으로 바꿔줌. 그래야 디데이 계산때 가능
    var date = formatter.parse(
        departure_date);
    //특정 날짜와 날짜 사이의 디데이를 계산
    var difference = date
        .difference(getToday())
        .inDays;
    var result = '';
    if (difference > 0) {
      result = '- ' + difference.toString();
    } else if (difference < 0) {
      difference = -difference; //부호를 +로 변경시켜주기위함
      result = '+ ' + difference.toString();
    } else { //디데이일때
      result = '- day';
    }
    //디데이 계산결과값 스트링을 state에 넘겨줌
    context.read<Store1>().ChangeDate(departure_date);
    //디데이 계산결과값 스트링을 state에 넘겨줌
    context.read<Store1>().ChangeDday(result);

  }



  /* DatePicker 띄우기 */
  showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      //초기값
      firstDate: DateTime(2022),
      //시작일
      lastDate: DateTime(2030),
      //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) { //날짜 선택 직후에 할일
      //유저가 cancel안하고 특정날짜를 선택했을때
      if (dateTime != null) {
        var formatter = DateFormat('yyyy-MM-dd');
        var formatDate = formatter.format(dateTime); //스트링타입으로 만들어진 유저가 선택한 날짜값
        //유저가 정한 날짜값String을 sharedpref에 저장
        saveData(formatDate);
        //디데이값을 계산해서 값을 변경해줌
        Dday_calculating(formatDate);


      }
    });
  }

  //오늘 날짜 가져오기
  getToday() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    var dateTime = formatter.parse(formatter.format(now));
    return dateTime;
  }

  //sharedpref에 유저정보 삭제
  deleteData(name) async {
    var storage = await SharedPreferences.getInstance();
    storage.remove('name');
  }

  //다이얼로그 보여줌




  @override
  void initState() {
    super.initState();
    //유저가 이전에 선택한 떠나는날짜값 있으면 가져와서 디데이값 계산해줌
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          //SliverAppBar의 높이 설정
          toolbarHeight: 50.0.h,
          //하단 List를 최상단으로 올렸을때의 SliverAppBar의 Default height
          //expandedHeight를 사용하면 스크롤을 내리면 toolbarheight높이까지 줄어든다.
          expandedHeight: 0.0.h,
          //SliverAppBar의 그림자 정도
          elevation: 0.0,
          //SliverAppBar title
          title: Text("Hello, ${context.watch<Store1>().username} !", style: TextStyle(color: Colors.black),),
          //SliverAppBar 영역을 고정시킨다. default false
          pinned: true,
          // AppBar가 하단 List 내렸을 때 바로 보여야 한다 -> true
          // List를 최상단으로 올렸을 때만 나와야 한다. -> false
          floating: true,


            actions: [
            //PopupMenu를 보여줌
            PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child:  TextButton(child: Text('Sign out', style: TextStyle(
                    color: Colors.black
                  ),), onPressed: (){   //로그아웃로직
                    //다이얼로그 띄우기
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text('Are you sure you want to sign out?',style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp
                        ),),
                        actions: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(onPressed: () async {
                                await auth.signOut(); //파베에서 로그아웃
                                var name = context.read<Store1>().username;
                                deleteData(name); //sharedpref에서도 유저 정보 삭제 - 이름값만 삭제해도 될듯. 이름만 보고 로그인됫는지 판별하니?

                                //로그인으로 페이지 이동
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (c) => authentic())
                                );

                                //모든 스택값에 있는 페이지삭제
                                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);

                              }, child: Text('Yes', style: TextStyle(color: Colors.green),)),
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, child: Text('No',style: TextStyle(color: Colors.green),)),

                            ],)
                        ],
                      ) ;
                    });  //다이얼로그
                  })
                ),
                PopupMenuItem(
                  value: 2,
                  child:  TextButton(child: Text('Delete Account', style: TextStyle(
                            color: Colors.black)), onPressed: (){  //계정삭제로직
                    //다이얼로그 띄우기
                    showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text('Are you sure you want to delete account?',style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp
                        ),),
                        actions: [
                          Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(onPressed: () async {

                                //현재 로그인된 파베유저 계정 삭제로직
                                await FirebaseAuth.instance.currentUser?.delete();

                                var name = context.read<Store1>().username;
                                deleteData(name); //sharedpref에서도 유저 정보 삭제 - 이름값만 삭제해도 될듯.

                                //로그인으로 페이지 이동
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (c) => authentic())
                                );

                                //모든 스택값에 있는 페이지삭제
                                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);

                              }, child: Text('Yes', style: TextStyle(color: Colors.green),)),
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                              }, child: Text('No',style: TextStyle(color: Colors.green),)),

                            ],)
                        ],
                      ) ;
                    });
                  })
                ),
              ],
              offset: Offset(0, 50),
              color: Colors.white,
              elevation: 2,
            ),
          ],






        ),
        
        //이름 보여줌
        SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Card(
                margin: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 20.h),
                elevation: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 40.w),
                      child: Text(
                          'Time left before returning home ',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black, fontSize: 16.sp)),
                    ),

                    SizedBox(
                      height: 50.h,
                      child: Text('D ' + context
                          .watch<Store1>()
                          .dday, style: TextStyle(fontSize: 25.sp,),),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Departure Date: ', style: TextStyle(
                          fontSize: 18.sp
                        )),
                        TextButton(onPressed: () {
                          showDatePickerPop(); //날짜픽업위젯보여줌
                        }, child: Text(context
                            .watch<Store1>()
                            .date,
                            style: TextStyle(
                                fontSize: 18.sp,
                              color: Colors.green
                            ))
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
        ),

        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            height: 360.h,
          ),
        )
      ],

    );
  }
}