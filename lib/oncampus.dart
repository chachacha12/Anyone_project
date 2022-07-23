import 'package:flutter/material.dart';
import 'main.dart';

//캠퍼스 관련 정보들을 다 담고있는 박스위젯
class OnCampus extends StatefulWidget {
  const OnCampus({Key? key}) : super(key: key);

  @override
  State<OnCampus> createState() => _OnCampusState();
}

class _OnCampusState extends State<OnCampus> {
  @override
  Widget build(BuildContext context) {
    return Column(                     //캠퍼스 정보를 보여주는 아이콘들을 담고 있는 박스같은 존재
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(                           //첫번째 가로줄
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(Icons.star),
                Text('ddd')
              ],
            ),
            Column(
              children: [
                Icon(Icons.star),
                Text('ddd')
              ],
            ),
            Column(
              children: [
                Icon(Icons.star),
                Text('ddd')
              ],
            )
          ],
        ),
        Row(                           //두번째 가로줄
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(Icons.star),
                Text('ddd')
              ],
            ),
            Column(
              children: [
                Icon(Icons.star),
                Text('ddd')
              ],
            ),
            Column(
              children: [
                Icon(Icons.star),
                Text('ddd')
              ],
            )
          ],
        ),
        Row(                           //세번째 가로줄
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Icon(Icons.star),
                Text('ddd')
              ],
            ),
            Column(
              children: [
                Icon(Icons.star),
                Text('ddd')
              ],
            ),
            Column(
              children: [
                Icon(Icons.star),
                Text('ddd')
              ],
            )
          ],
        ),
      ],
    );
  }
}
