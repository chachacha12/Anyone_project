import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';



class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

        ),
        body: SfCalendar(
            allowAppointmentResize: true,
            allowDragAndDrop: true,
            viewNavigationMode: ViewNavigationMode.none,
            initialDisplayDate: DateTime.now(),
            showCurrentTimeIndicator: true,
            view: CalendarView.workWeek,
            firstDayOfWeek: 1,
            dataSource: MeetingDataSource(_getDataSource()), //일정들 표시해주는 역할
            timeSlotViewSettings: TimeSlotViewSettings(
                startHour: 8,
                endHour: 21,),
        ),
    );
  }

  ///일정들 여기서 생성해서 리스트형태로 반환해주는 함수
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();


    /// 특정날짜가 속한 주의 월요일 날짜 구하는 방법: today.day - (today.weekday - 1)
    /// 즉, 특정요일에 일정을 표시할거면 위에서 구한 월요일날짜에 +1, +2 등을 해서 이번주의 화요일, 수요일 등을 구할 수 있음
    final DateTime startTime =
    DateTime(today.year, today.month, today.day - (today.weekday - 1)+4, 11,0);

    final DateTime endTime =
    DateTime(today.year, today.month, today.day - (today.weekday - 1)+4, 13,0);

    meetings.add(
        Meeting('Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

///일정들 리스트를 인자로 받아서 SfCalendar위젯의 인자값으로 넣어주는 역할하는 객체 생성
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




