import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';



class Clubs extends StatelessWidget {
  const Clubs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            'Clubs',
          ),
          ),

          //contactus와 애니원메일버튼, schoolcontact. 즉 3개 박스 들어감
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 0.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('How to join?', style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp
                  )),
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0.h),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "\n"'● Application procedure is all depending on each clubs’ rule.'"\n\n"
                          '● You should directly ask to a president of a club, asking specific timeline & activities.'"\n"
                          '(Usually recruiting starts during the first month of a new semester)'"\n\n"
                          '● Looking around the lists we’ve provided below and try to ask if you could join !'"\n",
                          style: TextStyle(
                            fontSize: 15.sp
                          )),
                    )
                  ),

                  Text("\n"'List', style: TextStyle(
                      color: Colors.black,
                      fontSize: 25.sp
                  )),
                ],
              ),
            ),
          ),

          //학교연락망들 보여주는 리스트
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    Card(        //리스트 속 각각의 객체 하나하나임
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                      /*
                      child: ListTile(
                        title: Text(contact_list[index][0], style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Text(contact_list[index][1], ),
                        trailing: Icon(Icons.phone_forwarded),
                        onTap: ()  {
                          _makePhoneCall(contact_list[index][1]);
                        },
                      ),
                       */
                    ),
                childCount: 4),
          ),

        ],
      ),
    );
  }
}


