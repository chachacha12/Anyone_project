import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        ),
        
        //이름 보여줌
        SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Card(
                margin: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 0.h),
                elevation: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 40.w),
                      child: Text(
                          'The time left before ${context.watch<Store1>().username} leaves for home country !',
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
                                fontSize: 18.sp
                            ))
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
        ),

      ],

    );
  }
}