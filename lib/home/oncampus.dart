import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';

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
      height: 300.0.h,
      width: double.infinity.w,
      child: GridView.count(
          crossAxisCount: 4,
          children: [
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('official site',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('OIA',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Dormitory',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Language'"\n"'Institution',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Academic'"\n"'Calender',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('GuideBook',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Library',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('School'"\n"'Contact',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Campus'"\n"'Map',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Clubs',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Tips',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin: EdgeInsets.all(10.0),
              child: GridTile(
                child:  Icon(Icons.star),
                footer: GridTileBar(
                  title: Text('Helplines',textAlign: TextAlign.center, style: TextStyle(
                      color: Colors.black
                  )),
                ),
              ),
            ),
          ],

      ),
    );
  }
}


