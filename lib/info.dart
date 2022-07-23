import 'package:flutter/material.dart';
import 'main.dart';
import 'oncampus.dart';

//캠퍼스와 일상생활 정보를 보여주는 첫 페이지
class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}


class _InfoState extends State<Info>  {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                 SliverAppBar(
                  actions: [IconButton(onPressed: (){

                  }, icon: Icon(Icons.settings),
                  iconSize: 30,)
                  ],
                  title: Text('Anyone'),
                  pinned: true,
                  floating: true,
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: [
                      Tab(text: 'On-Campus',),
                      Tab(text: 'Around-Campus',)
                    ],
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 1,
                    indicatorColor: Colors.white,
                    unselectedLabelColor: Color(0xFFDDDDDD),
                    labelColor: Colors.white,
                    unselectedLabelStyle: TextStyle(color: Colors.pinkAccent, fontSize: 15),
                    labelStyle: TextStyle(
                        color: Colors.amber, fontSize:23, fontWeight: FontWeight.bold),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                OnCampus(), Text('일상생활관련/n'),
              ],
            ),
          )),
    );
  }
}

