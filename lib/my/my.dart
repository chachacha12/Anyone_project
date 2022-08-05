import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:intl/intl.dart';

//회원가입 및 로그인한 유저의 정보를 보여주는 페이지
class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {

  /* DatePicker 띄우기 */
  showDatePickerPop() {
    Future<DateTime?> selectedDate = showDatePicker(
      context: context,
      initialDate: DateTime.now(), //초기값
      firstDate: DateTime(2022), //시작일
      lastDate: DateTime(2030), //마지막일
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light(), //다크 테마
          child: child!,
        );
      },
    );

    selectedDate.then((dateTime) {      //날짜 선택 직후에 할일
      //유저가 cancel안하고 특정날짜를 선택했을때
      if(dateTime != null){
        var formatter = DateFormat('yyyy-MM-dd');
        var formatDate = formatter.format(dateTime);  //스트링타입으로 만들어진 유저가 선택한 날짜값
        var date = formatter.parse(formatDate);  //유저가 선택한 날짜값을 Date타입으로. 두 날짜 빼기 해야해서
        //날짜 State를 선택한 String 날짜값으로 변경해줌
        context.read<Store1>().ChangeDate(formatDate.toString());

        //특정 날짜와 날짜 사이의 디데이를 계산
        var difference = date.difference(getToday() ).inDays;
        var result ='';
        if(difference > 0){
          result = '- '+difference.toString();
        }else if(difference < 0){
          difference = -difference;    //부호를 +로 변경시켜주기위함
          result = '+ '+difference.toString();
        }else{      //디데이일때
          result = '- day';
        }
        //디데이 계산결과값 스트링을 state에 넘겨줌
        context.read<Store1>().ChangeDday(result);

        //토스트메시지 띄우기
        Fluttertoast.showToast(
          msg: difference.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          //fontSize: 20,
          //textColor: Colors.white,
          //backgroundColor: Colors.redAccent
        );
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
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          //SliverAppBar의 높이 설정
          toolbarHeight: 50.0.h,
          //SliverAppBar의 backgroundcolor
          backgroundColor: Colors.transparent,
          //하단 List를 최상단으로 올렸을때의 SliverAppBar의 Default height
          //expandedHeight를 사용하면 스크롤을 내리면 toolbarheight높이까지 줄어든다.
          expandedHeight: 0.0.h,
          //SliverAppBar의 그림자 정도
          elevation: 0.0,
          //SliverAppBar title
          title: Text("My Information", style: TextStyle(color: Colors.black),),
          //SliverAppBar 영역을 고정시킨다. default false
          pinned: true,
          // AppBar가 하단 List 내렸을 때 바로 보여야 한다 -> true
          // List를 최상단으로 올렸을 때만 나와야 한다. -> false
          floating: true,
        ),

        //이메일, 풀네임, 닉네임을 보여줌
        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
            height: 150.0.h,
            child: Container(
              color: Colors.green,
              width: 200.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('E-mail:  '),
                      Text('12zxccha@'),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Full Name:  '),
                      Text('chaminwoo')
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Nickname:  '),
                      Text('chachacha')
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            height: 300.h,
            width: 100.0.w,
            child: Container(
              alignment: Alignment.center,
              color: Colors.yellow,
              height: 300.0.h,
              width: 250.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('D '+context.watch<Store1>().dday),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Departure Date:     '),
                      TextButton(onPressed: (){
                        showDatePickerPop();  //날짜픽업위젯보여줌
                      }, child: Text(context.watch<Store1>().date)
                      )
                    ],
                  ),

                ],
              ),
              ),
          ),
        ),

      ],

    );
  }
}