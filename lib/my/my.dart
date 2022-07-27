import 'package:flutter/material.dart';

//유저정보 보여주는 페이지
class My extends StatefulWidget {
  const My({Key? key}) : super(key: key);

  @override
  State<My> createState() => _MyState();
}

class _MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return Text('내정보');
  }
}