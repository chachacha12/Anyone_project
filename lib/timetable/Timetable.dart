import 'dart:ffi';

import 'package:anyone/timetable/Addclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../main.dart';

//store에는 각각의 시간표 일정들이 map 형태로 저장되어 있음. {'index': 1 ,  'name': class, 'dayofweek': 0   ....등등}
// sharedpref에는 List<string>으로 되어있고.. ['index': '1' ,'name', '1', '10','30', '13', '30'] 등..차례로 index, 수업이름+빌딩+방번호, 요일, 시작hour, 시작minute, 끝hour, 끝minute
//shared pref로부터 일정들의 리스트를 15번 쭉 돌면서 있는것들만 가져와서 map형태로 변환해줌. 그후 그 map을 store에 저장해주면 화면에 보여질것임

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {

  /// sharedpref에 저장된 수업일정 for문 통해 가져옴 - 15개 저장되는 배열속에서
  getData() async {
    print('timetable getData실행');

    var storage = await SharedPreferences.getInstance();
    //store에 있는 map타입 수업들 저장해두는 리스트 가져옴..앱 처음 실행하면 null값 15개가 초기화되어있음.
    var unCompleteMeetings = context.read<Store1>().unCompleteMeetings;
    for(int i=0; i<unCompleteMeetings.length; i++){
      //만약 i번째 key값이 있으면 그 List<String>값 가져옴
      if(storage.containsKey('class'+i.toString()) ){
        var list = storage.getStringList('class'+i.toString());
        print('timetalbe 중 storage.getStringList 해서 가져온값: '+list.toString());
        var map =  {'index': int.parse(list![0]) ,  'name':list[1], 'dayofweek': int.parse(list[2]), 'starthour': int.parse(list[3]) , 'startminute': int.parse(list[4]) , 'endhour': int.parse(list[5])  , 'endminute': int.parse(list[6]) };
        print('Timetable에서 getData로 sharedpref에서 가져오는 map의 순서: '+i.toString()+', map: '+map.toString());
        //store에 있는 리스트의 특정 index에 새 수업정보 적힌 map값 저장
        context.read<Store1>().addIndexMeetingsData(int.parse(list[0]), map);
      }
    }
    print('timetable getData실행 완료');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Time table'),
          elevation: 0,
          actions: [
            ///클릭시 일정 추가하는 페이지로 이동
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>
                     Addclass()
              ));
            }, icon: Icon(Icons.add_box_outlined)),
            ///지도 보여주는 페이지로 이동
            IconButton(onPressed: (){}, icon: Icon(Icons.location_pin))
          ],
        ),
        body: SfCalendar(
            backgroundColor: Colors.white,
            //allowAppointmentResize: true,
            allowDragAndDrop: true,
            viewNavigationMode: ViewNavigationMode.none,
            initialDisplayDate: DateTime.now(),
            showCurrentTimeIndicator: true,
            view: CalendarView.workWeek,
            firstDayOfWeek: 1,
            dataSource: MeetingDataSource(_getDataSource()), ///일정들 표시해주는 역할
            timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 8,
                endHour: 21,),
        ),
    );
  }

  ///일정들 여기서 생성해서 리스트형태로 반환해주는 함수
    List<Meeting> _getDataSource()  {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();

    print('_getDataSource실행#@@@@@@@@@@@');
    //store에서 수업스케줄 리스트 가져옴
    var list = context.read<Store1>().unCompleteMeetings;

    print('_getDataSource할때 store에서 가져온 list: '+list.toString());

    //저장된 수업들 리스트 가져와서 여기서 하나씩 생성해줌
    for(int i=0; i<list.length; i++){
      if(list[i] != null){
        /// 특정날짜가 속한 주의 월요일 날짜 구하는 방법: today.day - (today.weekday - 1)
        /// 즉, 특정요일에 일정을 표시할거면 위에서 구한 월요일날짜에 +1, +2 등을 해서 이번주의 화요일, 수요일 등을 구할 수 있음
        int dayofweek = list[i]!['dayofweek'];
        DateTime startTime =
        DateTime(today.year, today.month, today.day - (today.weekday - 1)+dayofweek, list[i]!['starthour'] ,list[i]!['startminute']) ;
        DateTime endTime =
        DateTime(today.year, today.month, today.day - (today.weekday - 1)+dayofweek,  list[i]!['endhour'],list[i]!['endminute'] );
        meetings.add(
            Meeting(list[i]!['name'], startTime, endTime, const Color(0xFF0F8644), false)
        );
      }
    }
    return meetings;
  }
}

///일정들 리스트를 인자로 받아서 SfCalendar위젯의 인자값으로 넣어주는 역할하는 객체
class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source){
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

///일정객체 하나를 만드는 클래스
class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}




