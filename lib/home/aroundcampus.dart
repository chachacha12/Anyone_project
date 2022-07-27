import 'package:flutter/material.dart';

//around-campus 관련 정보들을 다 담고있는 박스위젯
class AroundCampus extends StatefulWidget {
  const AroundCampus({Key? key}) : super(key: key);

  @override
  State<AroundCampus> createState() => _AroundCampusState();
}

class _AroundCampusState extends State<AroundCampus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[

            //아이콘들 보여줌
            SliverToBoxAdapter(
              child: Container(
                height: 300.0,
                child: GridView.count(
                  crossAxisCount: 4,
                  children: [
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: GridTile(
                        child: Icon(Icons.star),
                        footer: GridTileBar(
                          title: Text('Grocery'"\n"'shopping',
                              textAlign: TextAlign.center, style: TextStyle(
                                  color: Colors.black
                              )),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: GridTile(
                        child: Icon(Icons.star),
                        footer: GridTileBar(
                          title: Text('Fashion'"\n"'&beauty',
                              textAlign: TextAlign.center, style: TextStyle(
                                  color: Colors.black
                              )),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: GridTile(
                        child: Icon(Icons.star),
                        footer: GridTileBar(
                          title: Text('cafe', textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black
                              )),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: GridTile(
                        child: Icon(Icons.star),
                        footer: GridTileBar(
                          title: Text('pub', textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black
                              )),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: GridTile(
                        child: Icon(Icons.star),
                        footer: GridTileBar(
                          title: Text('Finance', textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black
                              )),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: GridTile(
                        child: Icon(Icons.star),
                        footer: GridTileBar(
                          title: Text('Hospital', textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black
                              )),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: GridTile(
                        child: Icon(Icons.star),
                        footer: GridTileBar(
                          title: Text('Facilities', textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black
                              )),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(10.0),
                      child: GridTile(
                        child: Icon(Icons.star),
                        footer: GridTileBar(
                          title: Text('Discount', textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                  height: 80.0,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 0, 0),
                    child: Row(
                      children: [
                        Text('KU students'"'"''"\n"'go-to Restaurant',
                            style: TextStyle(fontSize: 20)),
                        Text(' 🍔', style: TextStyle(fontSize: 35)),
                        Expanded(child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(onPressed: () {

                              }, child: Text('more'),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    onPrimary: Colors.white),
                              ),
                            ],
                          ),
                        ))

                      ],
                    ),
                  )
              ),
            ),


            //맛집목록들 수평리스트로 보여줌
            SliverToBoxAdapter(
              child: Container(
                height: 150.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 150.0,
                        child: Card(
                          child: Text('data'),
                        ),
                      );
                    }),
              ),
            ),
            /*
            SliverList(
              delegate: SliverChildBuilderDelegate(
                      (context, index) => ListTile(
                    title: Text('Item #$index'),
                  ),
                  childCount: 10),
            ),
             */
          ],
        ));
  }
}

