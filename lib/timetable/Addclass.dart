import 'package:anyone/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Addclass extends StatefulWidget {
  const Addclass({Key? key}) : super(key: key);

  @override
  State<Addclass> createState() => _AddclassState();
}


class _AddclassState extends State<Addclass> {

  ///텍스트필드 값을 저장할 리스트
  List<dynamic> inputData =['','','','','',''];

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
                Flexible(child: TextField(
                  onChanged: (text){ inputData[1] = text;  },
                  decoration: getTextFieldStyle('Monday'),
                ), flex: 4),
                SizedBox(width: 10.w,),
                Flexible(child: TextField(
                  onChanged: (text){ inputData[2] = text;  },
                  decoration: getTextFieldStyle('Start Time'),
                ), flex: 3),
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
                Flexible(child: TextField(
                  onChanged: (text){ inputData[4] = text;  },
                  decoration: getTextFieldStyle('Building'),
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
getTextFieldStyle(hint){
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





