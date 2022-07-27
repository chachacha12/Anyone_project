import 'package:flutter/material.dart';
import 'main.dart';

//on-campus 관련 정보들을 다 담고있는 박스위젯
class OnCampus extends StatefulWidget {
  const OnCampus({Key? key}) : super(key: key);

  @override
  State<OnCampus> createState() => _OnCampusState();
}

class _OnCampusState extends State<OnCampus> {
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(      //캠퍼스 정보를 보여주는 아이콘들을 담고 있는 박스같은 존재
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(              //첫번째 가로줄
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('official site')
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('Academic'"\n"'calender')
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('Campus'"\n"'Map')
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(              //첫번째 가로줄
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('OIA')
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('GuideBook')
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('clubs')
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0 , 0, 0),
            child: Column(                           //두번째 가로줄
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('Dormitory')
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('Library')
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('Tips'),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Column(                           //세번째 가로줄
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('Language'"\n"'Institution')
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('School'"\n"'Contact')
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.star),
                    Text('Helplines')
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
