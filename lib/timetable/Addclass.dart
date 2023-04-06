import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../main.dart';
import 'Timetable.dart';


//store에 각각의 시간표 일정들을 map 형태로 저장해줄거임.  {'index':1,  name': class, 'dayofweek': 0   ....등등}
//sharedpref에만 List<String>으로 해줄거
class Addclass extends StatefulWidget {
  const Addclass({Key? key}) : super(key: key);

  @override
  State<Addclass> createState() => _AddclassState();
}



class _AddclassState extends State<Addclass> {

  ///새로운 수업의 내용을 저장할 map. 순서대로:  저장된 리스트의 index번호, 수업제목+(수업위치), 요일값(숫자로), starthour, startminute, endhour,endminute 이 들어갈거임
  Map<String, dynamic> classContentMap = {};

  ///화면에 보여줄 start time과 end time 저장
  var starttime_btn = 'Start time';
  var endtime_btn = 'End time';


  ///수업제목+빌딩번호+방번호값, 요일값, 시작시간, 끝시간 저장해줄 변수 (이 변수들로 유저가 모든 값 입력했는지 확인해줄것임)
  var className;  //수업이름
  var selectedbuilding = '';  //빌딩
  var roomNumber; //방번호
  var selectedDay = '';  //요일
  var startHour;
  var startMinute;
  var endHour;
  var endMinute;

  ///요일선택 드롭박스를 위한 map
  final daylist = {'Monday':0, 'Tuesday':1, 'Wednesday':2, 'Thursday':3, 'Friday':4};

  ///빌딩선택 드롭박스를 위함
  final buildinglist = [
    'Administration Bldg',
    'Business Administration Bldg',
    'Sanghuh Hall',
    'Education Science Bldg',
    'Art & Design Bldg',
    'Konkuk Language Institute',
    'Law School Bldg',
    'Biomedical Science Bldg',
    'Life Science Bldg',
    'Animal Science Bldg',
    'Admissions & Information Technology Bldg',
    'Industry-University Cooperation Bldg',
    'Veterinary Medicine Bldg',
    'New Millennium Hall',
    'Architecture Bldg',
    'Hae-Bong Real Estate Bldg',
    'Liberal Arts Bldg',
    'Student Union Bldg',
    'Engineering Bldg',
    'New Engineering Bldg',
    'Science Bldg',
    'Chang-ui Bldg',
    'Gymnasium',
  ];


  ///shared pref에 새로운 수업스케줄 저장
  savePreference() async {
    var storage = await SharedPreferences.getInstance();

    //classContentMap의 값들로 List<String> 타입으로 만듬 (sharedpref에 저장하기 위함)
    List<String> classContentList = [
      classContentMap['index'].toString(),
      classContentMap['name'].toString(),
      classContentMap['dayofweek'].toString(),
      classContentMap['starthour'].toString(),
      classContentMap['startminute'].toString(),
      classContentMap['endhour'].toString(),
      classContentMap['endminute'].toString(),
    ];
    storage.setStringList('class'+classContentMap['index'].toString(), classContentList);
    print('shared pref에 저장성공: '+'키값: '+'class'+classContentMap['index'].toString()+', value: '+classContentList.toString());
  }

  ///Provider의 store에 새 수업스케줄 저장
  saveStore(){
    //만약 방번호가 null값이면 ''으로 바꿔줌. 즉 방번호는 미작성해도됨
    roomNumber ??= '';
    //새 수업의 네임, 빌딩, 방번호 저장
    classContentMap['name'] =
        className + '\n' + '(' + selectedbuilding.toString() +
            ' ' + roomNumber+')';
    //요일값 저장 (ex. 월요일 = 0)
    classContentMap['dayofweek'] = daylist[selectedDay];
    //시작시간, 끝시간 유저가 선택한 값 int로 저장
    classContentMap['starthour'] = startHour;
    classContentMap['startminute'] = startMinute;
    classContentMap['endhour'] = endHour;
    classContentMap['endminute'] = endMinute;

    var unCompleteMeetings = context.read<Store1>().unCompleteMeetings;
    //store에 저장되어 있는 수업일정들 리스트의 길이인 15만큼 반복
    for(int i=0; i<= unCompleteMeetings.length; i++){
      print('unCompleteMeetings.length만큼 반복: '+ i.toString());
      //수업리스트들 중 빈 index가 있다면 거기에 새 수업을 넣어줌
      if(unCompleteMeetings[i] == null){
        print('Addclass 중 unCompleteMeetings[i] == null 이라서 store에 저장되는 addIndexMeetingsData 실행@@@@');
        print('Addclass 중 unCompleteMeetings[i] i번째에 저장:  '+i.toString());
        classContentMap['index'] = i;
        //store에 새 수업정보 적힌 map값 저장
        context.read<Store1>().addIndexMeetingsData(i, classContentMap);
        break;
      }
    }
  }

  /// TimePicker 띄워주는 함수
  void showTimePickerPop(int option) {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime.then((timeOfDay) {
      setState(() {
        if (timeOfDay?.hour != null) {
          if (option == 0) { //0이면 start time 선택했을때고 1이면 endtime 선택했을때임
            starttime_btn = '${timeOfDay?.hour}:${timeOfDay?.minute }';
            startHour = timeOfDay?.hour;
            startMinute = timeOfDay?.minute;
          } else {
            endtime_btn = '${timeOfDay?.hour}:${timeOfDay?.minute }';
            endHour = timeOfDay?.hour;
            endMinute = timeOfDay?.minute;
          }
        } else { //시간 선택안하고 그냥 취소했을시 Text값에 null값 들어오는거 방지용
        }
      });
    });
  }


  @override
  void initState() {
    super.initState();
    setState(() {
      ///드롭다운박스 초기 선택된 아이템값
      selectedDay = daylist.keys.first;
      selectedbuilding = buildinglist[0];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.h,
        title: Text('Create New Class'),
        elevation: 0,
        centerTitle: false,
        actions: [
          Container(
            margin: EdgeInsets.fromLTRB(0.w, 15.h, 23.w, 15.h),
            width: 60.w,
            /// 일정추가 완료 버튼 클릭시
            child: ElevatedButton(onPressed: () {
              /// 드롭박스라 원래 초기화되어있는 요일과 빌딩값 빼고 다른값들이 null인지 체크함. 그리고 수업이름은 빈칸이면 안됨, 방번호는 빈칸이라도 괜찮음
              if( className !=null && className!=''  && startHour  !=null   && endHour  !=null    ) {
                //store에 새 수업스케줄 저장해서 화면에 바로 반영
                saveStore();
                savePreference();
                Navigator.pop(context);
                print('통과: '+'@@@@  className: $className +  roomNumber: $roomNumber+   startHour: $startHour +  endHour: $endHour +  selectedDay: $selectedDay +  selectedbuilding:  $selectedbuilding');
           }else{
                print('불통과: '+'@@@@  className: $className +  roomNumber: $roomNumber+   startHour: $startHour +  endHour: $endHour +  selectedDay: $selectedDay +  selectedbuilding:  $selectedbuilding');
                //토스트메시지 띄우기
                Fluttertoast.showToast(
                  msg: 'please Fill in all the blanks',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  //fontSize: 20,
                  //textColor: Colors.white,
                  //backgroundColor: Colors.redAccent
                );
              }
            }, child: Text('Done'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp)
                )
            ),
          )
        ],
      ),

      body: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 45.h,
                child: TextField(
                  onChanged: (text) {
                    className = text;
                  },
                  decoration: getTextFieldStyle('Class Name'),
                ),
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(3.w, 15.h, 0.w, 5.h),
                child: Text('Class Time Info', style: TextStyle(
                    color: Colors.green
                ),),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///드롭다운박스를 통해 요일 선택
                  Flexible(child: DropdownButton(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    isExpanded: true,
                    //글씨길면 줄바꿈해줌
                    value: selectedDay,
                    items: daylist.keys
                        .map((e) =>
                        DropdownMenuItem(
                          value: e, // 선택 시 onChanged 를 통해 반환할 value
                          child: Text(e),
                        ))
                        .toList(),
                    onChanged: (value) { // items 의 DropdownMenuItem 의 value 반환
                      setState(() {
                        selectedDay = value.toString();
                      });
                    },
                  ),
                      flex: 3),
                  SizedBox(width: 10.w,),
                  ///start time값 받는 버튼
                  Flexible(child: OutlinedButton(
                    style: getButtonStyle(),
                    child: Text(starttime_btn, style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                    ),),
                    onPressed: () {
                      showTimePickerPop(0);
                    },
                  ), flex: 3),

                  SizedBox(width: 10.w,),

                  ///End time값 받는 버튼
                  Flexible(child: OutlinedButton(
                    style: getButtonStyle(),
                    child: Text(endtime_btn, style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp,
                    ),),
                    onPressed: () {
                      showTimePickerPop(1);
                    },
                  ), flex: 3),
                ],
              ),

              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(3.w, 15.h, 0.w, 5.h),
                child: Text('Class Location Info', style: TextStyle(
                    color: Colors.green
                ),),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///드롭다운박스를 통해 빌딩선택
                  Flexible(child: DropdownButton(
                    alignment: Alignment.center,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    itemHeight: 65.h,
                    menuMaxHeight: 500.h,
                    isExpanded: true,
                    //글씨길면 줄바꿈해줌
                    value: selectedbuilding,
                    items: buildinglist
                        .map((e) =>
                        DropdownMenuItem(
                          value: e, // 선택 시 onChanged 를 통해 반환할 value
                          child: Text(e,),
                        ))
                        .toList(),
                    onChanged: (value) { // items 의 DropdownMenuItem 의 value 반환
                      setState(() {
                        selectedbuilding = value.toString();
                      });
                    },
                  ), flex: 5),

                  SizedBox(width: 10.w,),
                  Flexible(child: Container(
                    padding: EdgeInsets.fromLTRB(0, 5.h, 0, 0),
                    height: 40.h,
                    child: TextField(
                      onChanged: (text) {
                        roomNumber = text;
                      },
                      decoration: getTextFieldStyle('Room number'),
                    ),
                  ), flex: 5),
                ],
              ),
            ],
          )
      ),
    );
  }
}

///텍스트필드 공통된 스타일값 반환해주는 함수
getTextFieldStyle(hint) {
  return InputDecoration(
    labelText: hint,
    labelStyle: TextStyle(fontSize: 13.sp, color: Colors.black),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.w),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.w),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
  );
}

///start time과 end time 버튼의 스타일값 반환함수
getButtonStyle(){
  return OutlinedButton.styleFrom(
      primary: Colors.black, // 글자, 애니메이션 색상
      backgroundColor: Colors.white, // 배경 색상
      side: BorderSide(
          color: Colors.black,
          width: 1
      )
  );
}







