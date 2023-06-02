import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Provider/Provider.dart';
import '../authentic/login.dart';
import '../authentic/signup.dart';
import '../main.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../various_widget.dart';

//회원가입 및 로그인한 유저의 정보를 보여주는 페이지
class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {

  //이메일 보내기 위한 작업
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'exchangestudents0906@gmail.com',
  );

  //sharedpref에 유저 한국 도착날짜 저장하기
  saveArrivalData(arrivalDate) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString('arrival_date', arrivalDate);
    // 도착날짜값을 state에 넘겨줘서 바로 ui상에서 변경
    context.read<Store1>().ChangeArrivalDate(arrivalDate);
  }


  //sharedpref에 유저 떠나는 날짜 저장하기
  saveDepartureData(departureDate) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString('departure_date', departureDate);
    //출국날짜값을 state에 넘겨줘서 바로 ui상에서 변경
    context.read<Store1>().ChangeDepartureDate(departureDate);
  }

  //sharedpref에 유저가 저장해둔 도착일과 떠나는 날짜 가져오기 - initState()에서 실행
  getData() async {
    var storage = await SharedPreferences.getInstance();

    //떠나는 날짜값 가져오기
    var departure_date = storage.getString('departure_date');
    if (departure_date != null) { //저장된 날짜값이 있다면
      //출국날짜값을 state에 넘겨줘서 ui상에서 보여줌
      context.read<Store1>().ChangeDepartureDate(departure_date);
      Dday_calculating(departure_date); //디데이를 계산하고 값을 변경해줌
    }
    var arrival_date = storage.getString('arrival_date');
    if (arrival_date != null) { //저장된 날짜값이 있다면
      //도착날짜값을 state에 넘겨줘서 ui상에서 보여줌
      context.read<Store1>().ChangeArrivalDate(arrival_date);
    }

    if(departure_date != null && arrival_date != null){
      Percent_Calculating(arrival_date, departure_date);  //그래프 퍼센트 계산해서 state에 저장. 즉 ui에 보여줌
    }
  }

  //디데이값을 계산해주는 메소드
  Dday_calculating(departure_date) {
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
    context.read<Store1>().ChangeDday(result);
  }

  //남은 체류기간 퍼센트 계산해주는 메소드
  Percent_Calculating(arrival_date ,departure_date){
    //유저가 출국일, 도착일 모두 선택한 경우
    if(arrival_date !=null && departure_date != null ){
      var formatter = DateFormat('yyyy-MM-dd');
      //받아온 string날짜값들을 String에서 Date타입으로 바꿔줌. 그래야 계산때 가능
      var arrivaldate = formatter.parse(arrival_date);
      var departuredate = formatter.parse( departure_date);
      ///한국에 머무는 총 일수 계산 (떠나는 날과 한국도착일 사이의 디데이를 계산)
      var difference = departuredate
          .difference(arrivaldate)
          .inDays;

      ///현재까지 머문 총 일수 계산 (오늘날짜와 한국도착일 사이의 디데이를 계산)
       var difference2 = getToday()
          .difference(arrivaldate)
          .inDays;
      var totalday = 0;  //totalday는 출국일과 도착일 사이의 총 일수 int 값
      var livingday = 0;
      ///한국에 머무는 총 일수 계산
      if (difference > 0) {
        totalday = difference;
      } else if (difference < 0) {
        totalday=1;
      } else { //디데이일때
        totalday=1;
      }

      ///한국도착일부터 오늘날까지 머문 총 일수 계산
      if (difference2 > 0) {
        livingday = difference2;
      } else if (difference2 < 0) { //아직까지 한국에 안 도착한 상황임. 한국도착날이 오늘날보다 더 미래인경우
        livingday=0;   //분자값을 0으로해서 계산때 퍼센트가 0이 나오게 함
      } else { //디데이일때
        livingday=1;
      }

      double percent=0.0;
      //이미 한국 떠난 상태일경우의 예외처리임
      if(livingday > totalday){
        percent=100;
      }else {
        //소수점 둘째까지만 보여줌
        percent = double.parse( (livingday / totalday * 100).toStringAsFixed(2)); //퍼센트 계산법 :    특정숫자 / 전체 * 100
      }
      context.read<Store1>().ChangePercent(percent);  //state를 통해 최종 퍼센트값을 저장해줌
    }else{ //미선택인 날짜값이 있을때
    }
  }

  ///도착일 or 출국일 피커를 클릭시 진행 (인자를 통해 어떤 날짜값 피커를 선택했는지 구분해줌. n==1이면 도착일, n==2이면 출국일)
  /* DatePicker 띄우기 */
  showDatePickerPop(n) {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      //초기값
      firstDate: DateTime(2020),
      //시작일
      lastDate: DateTime(2035),
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

        if(n==1){  //유저가 도착일 피커를 선택한것일때
          saveArrivalData(formatDate);
          //그래프 퍼센트 계산시작
          Percent_Calculating( formatDate, context.read<Store1>().departure_date);
        }else{  //유저가 출국일 피커 선택일때
          //유저가 정한 출국날짜값String을 sharedpref에 저장
          saveDepartureData(formatDate);
          //디데이값을 계산해서 값을 변경해줌
          Dday_calculating(formatDate);
          //그래프 퍼센트 계산시작
          Percent_Calculating( context.read<Store1>().arrival_date, formatDate);
        }
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
          title: Text("Hello, ${context
              .watch<Store1>()
              .username} !", style: onCampusAppBarStyle(),),
          //SliverAppBar 영역을 고정시킨다. default false
          pinned: true,
          // AppBar가 하단 List 내렸을 때 바로 보여야 한다 -> true
          // List를 최상단으로 올렸을 때만 나와야 한다. -> false
          floating: true,
          actions: [
            popUpMenu()
          ],
        ),

        ///앱바 다음에 보여줄 박스
        SliverToBoxAdapter(
            child: dDayPercent()
        ),

        SliverToBoxAdapter(
          child:  Container(
            color: Colors.white,
            child: Container(
              margin: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  Contact Us', style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp
                   )),

                  Card(
                    elevation: 1,
                    margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0.h),
                    child: ListTile(
                      //title: Text('Team <Anyone>\n', style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text('Please send us new, or changed information!',
                          style: TextStyle(
                            color: Color(0xff706F6F),
                            fontSize: 14.sp
                            )),
                      trailing: Icon(Icons.email, size: 25.h),
                      onTap: (){
                        launchUrl(emailLaunchUri);    //이메일보내기
                      },
                    ),
                  ),
                ],
              ),
            )
          ),
          ),

        SliverToBoxAdapter(
          child: Container(
            color: Colors.white,
            height: 0.h,
          ),
        )
      ],
    );
  }


  /// 디데이날짜와 퍼센테이지바와 도착일, 출발일 피커 등 있는 박스
  dDayPercent() {
    return Container(
      color: Colors.white,
      child: Card(
        margin: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 20.h),
        elevation: 1,
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 10.w),
              child: Text(
                  'Time left before returning home ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.black, fontSize: 16.sp)),
            ),

            ///디데이 계산
            SizedBox(
              height: 30.h,
              child: Text('D ' + context
                  .watch<Store1>()
                  .dday, style: TextStyle(fontSize: 25.sp,),),
            ),

            ///퍼센테이지 그래프
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 10.w),
              child: LinearPercentIndicator(
                width: 275.w,
                animation: true,
                lineHeight: 18.0.h,
                animationDuration: 1000,
                percent: context
                    .watch<Store1>()
                    .percent / 100.0,
                center: Text(context
                    .watch<Store1>()
                    .percent
                    .toString() + '%'),
                barRadius: const Radius.circular(8),
                progressColor: Color(0xff73c088),
              ),
            ),

            ///도착일, 출발일 picker
            Container(
              margin: EdgeInsets.fromLTRB(20.w, 15.h, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('Arrival Date:       ', style: TextStyle(
                          fontSize: 15.sp
                      )),
                      TextButton(onPressed: () {
                        showDatePickerPop(
                            1); //날짜픽업위젯보여줌. 인자값 1을줘서 유저가 도착일을 세팅하려함을 전달
                      }, child: Text(context
                          .watch<Store1>()
                          .arrival_date,
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xff73c088),
                          ))
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('Departure Date: ', style: TextStyle(
                          fontSize: 15.sp
                      )),
                      TextButton(onPressed: () {
                        showDatePickerPop(
                            2); //날짜픽업위젯보여줌. 인자값 2를 줘서 유저가 출국일을 세팅하려함을 전달
                      }, child: Text(context
                          .watch<Store1>()
                          .departure_date,
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: Color(0xff73c088)
                          ))
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  ///팝업메뉴를 보여주는 함수
  popUpMenu(){
    return //PopupMenu를 보여줌
      PopupMenuButton<int>(
        itemBuilder: (context) =>
        [
          PopupMenuItem(
              value: 1,
              child: GestureDetector( //사이즈박스에 클릭이벤트 주기위함
                child: SizedBox(
                  width: double.infinity,
                  //height: double.infinity,
                  child: Text('Sign out', style: TextStyle(
                      color: Colors.black
                  )),
                ),
                onTap: () { //로그아웃 글씨가 있는 Sizedbox를 클릭했을시 이벤트 처리
                  //다이얼로그 띄우기
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text('Are you sure you want to sign out?',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp
                        ),),
                      actions: [
                        Row(mainAxisAlignment: MainAxisAlignment
                            .spaceAround,
                          children: [
                            TextButton(onPressed: () async {
                              await auth.signOut(); //파베에서 로그아웃
                              var name = context
                                  .read<Store1>()
                                  .username;
                              deleteData(
                                  name); //sharedpref에서도 유저 정보 삭제 - 이름값만 삭제해도 될듯. 이름만 보고 로그인됫는지 판별하니?

                              //로그인으로 페이지 이동
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (c) =>
                                      authentic())
                              );

                              //모든 스택값에 있는 페이지삭제
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (_) => false);
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
                },
              )
          ),
          PopupMenuItem(
              value: 2,
              child: GestureDetector(
                child: SizedBox(
                  width: double.infinity,
                  child: Text('Delete Account', style: TextStyle(
                      color: Colors.black)),
                ),
                onTap: () {
                  //다이얼로그 띄우기
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: Text(
                        'Are you sure you want to delete account?',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.sp
                        ),),
                      actions: [
                        Row(mainAxisAlignment: MainAxisAlignment
                            .spaceAround,
                          children: [
                            TextButton(onPressed: () async {
                              //현재 로그인된 파베유저 계정 삭제로직
                              await FirebaseAuth.instance.currentUser
                                  ?.delete();
                              var name = context
                                  .read<Store1>()
                                  .username;
                              deleteData(
                                  name); //sharedpref에서도 유저 정보 삭제 - 이름값만 삭제해도 될듯.
                              //로그인으로 페이지 이동
                              Navigator.push(context,
                                  CupertinoPageRoute(builder: (c) =>
                                      authentic())
                              );
                              //모든 스택값에 있는 페이지삭제
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/', (_) => false);
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
                },
              )
          ),
        ],
        offset: Offset(0, 50),
        color: Colors.white,
        elevation: 2,
        icon: Icon(Icons.more_vert, color: Colors.black),
      );
  }

}