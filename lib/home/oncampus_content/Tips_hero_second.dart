import 'package:flutter/material.dart';



class Tips_hero_second extends StatelessWidget {
   Tips_hero_second(this.tips_document, {Key? key}) : super(key: key);
  final tips_document ;  //팁컨텐츠 하나를 가져옴. 맵타입

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            'tips',
          ),
          ),

          SliverToBoxAdapter(
            child: Hero(
              tag: tips_document['title'],
              child: Image.network(tips_document['imagepath'][0]),
            ),
          )

        ],
      ),
    );
  }
}



