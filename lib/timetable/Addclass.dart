import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';



class Addclass extends StatefulWidget {
  const Addclass({Key? key}) : super(key: key);

  @override
  State<Addclass> createState() => _AddclassState();
}



class _AddclassState extends State<Addclass> {

  ///텍스트필드 값을 저장할 리스트. 순서대로:   수업제목+수업위치, 요일값(숫자로), starthour, startminute, endhour,endminute
  List<dynamic> inputData =['', 0,   0, 0, 0, 0 ];

  ///타임피커 통해 start time과 end time 저장
  var starttime_btn = 'Start time';
  var endtime_btn = 'End time';


  ///요일선택 드롭박스를 위함
  final daylist = ['Monday', 'Tuesday','Wednesday','Thursday','Friday'];
  String selectedday = '';

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
  String selectedbuilding = '';


  /// TimePicker 띄워주는 함수
  void showTimePickerPop(int option) {
    Future<TimeOfDay?> selectedTime = showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    selectedTime.then((timeOfDay) {
      setState(() {
        if(option == 0){   //0이면 start time 선택했을때고 1이면 endtime 선택했을때임
          starttime_btn = '${timeOfDay?.hour}:${timeOfDay?.minute }';
        }else{
          endtime_btn = '${timeOfDay?.hour}:${timeOfDay?.minute }';
        }

      });
    });
  }



  @override
  void initState() {
    super.initState();
    setState(() {
      ///드롭다운박스 초기 선택된 아이템값
      selectedday = daylist[0];
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
            width:  60.w,
            child: ElevatedButton(onPressed: (){  /// 일정추가 완료 버튼 클릭시

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
            TextField(
                onChanged: (text){ inputData[0] = text;  },
                decoration: getTextFieldStyle('Class Name'),
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
                  isExpanded: true, //글씨길면 줄바꿈해줌
                  value: selectedday,
                  items: daylist
                      .map((e) => DropdownMenuItem(
                    value: e, // 선택 시 onChanged 를 통해 반환할 value
                    child: Text(e),
                  ))
                      .toList(),
                  onChanged: (value) { // items 의 DropdownMenuItem 의 value 반환
                    setState(() {
                      selectedday = value.toString();
                    });
                  },
                ),
                flex: 4),
                SizedBox(width: 10.w,),
                Flexible(child: ElevatedButton(
                child: Text(starttime_btn),
                   onPressed:(){
                    showTimePickerPop(0);
                  },
                ), flex:3),

                SizedBox(width: 10.w,),

                Flexible(child: TextField(
                  onChanged: (text){ inputData[3] = text;  },
                  decoration: getTextFieldStyle('End Time'),
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
                  alignment:Alignment.center,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  itemHeight: 65.h,
                  menuMaxHeight: 500.h,
                  isExpanded: true, //글씨길면 줄바꿈해줌
                  value: selectedbuilding,
                  items: buildinglist
                      .map((e) => DropdownMenuItem(
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
                Flexible(child: TextField(
                  onChanged: (text){ inputData[5] = text;  },
                  decoration: getTextFieldStyle('Room number'),
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
      borderRadius: BorderRadius.circular(10.w),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.w),
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    ),
  );
}










