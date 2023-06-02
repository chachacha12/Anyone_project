import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../various_widget.dart';



//학교 연락망 리스트를 보여주는 커스텀 위젯 - customScrollView로 앱바포함 모두 자연스러운 스크롤 되도록 함
class Contact extends StatelessWidget {
   Contact({Key? key}) : super(key: key);

   //학교 연락망들을 리스트속에 리스트로 저장.
  var contact_list =[
      ['OIA, for exchange students\n(국제교류협력팀)\n','02-2049-6212', '02-2049-6212'],
      ['OIA, for studying abroad\n(외국인학생센터)\n', '02-2049-6213', '02-2049-6213'],
      ['language institution\n','02-450-3075~6', '02-450-3075'],
      ['KUL:HOUSE(Dormitory)\n','02-2024-5000~5003', '82-2-2024-5000'],
  ];

    //이메일 보내기 위한 작업
   final Uri emailLaunchUri = Uri(
     scheme: 'mailto',
     path: 'exchangestudents0906@gmail.com',
   );

   //전화거는 함수
   Future<void> _makePhoneCall(String phoneNumber) async {
     final Uri launchUri = Uri(
       scheme: 'tel',
       path: phoneNumber,
     );
     await launchUrl(launchUri);
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //fragment같은게 아닌 아예 새페이지를 띄울땐 Scaffold를 감싸서 띄워주어야 페이지 제대로 띄워지는듯
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: Text(
            'School Contact', style: onCampusAppBarStyle(),
          ),
          ),

          //contactus와 애니원메일버튼, schoolcontact. 즉 3개 박스 들어감
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              child: Container(
                color: Colors.white,
                margin: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 0.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Contact Us', style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp
                    )),
                    Card(
                      elevation: 1,
                      margin: EdgeInsets.fromLTRB(0, 10.h, 0, 20.h),
                      child: ListTile(
                        title: Text('< Anyone >\n', style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Text('exchangestudents0906@gmail.com'),
                        trailing: Icon(Icons.email),
                        onTap: (){
                          launchUrl(emailLaunchUri);    //이메일보내기
                        },
                      ),
                    ),

                    Text("\n"'School Contact', style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 18.sp
                    )),
                  ],
                ),
              ),
            ),
          ),

          //학교연락망들 보여주는 리스트
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    Container(
                      color: Colors.white,
                      child: Card(        //리스트 속 각각의 객체 하나하나임
                        elevation: 1,
                        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                        child: ListTile(
                          title: Text(contact_list[index][0], style: Theme.of(context).textTheme.titleMedium),
                          subtitle: Text(contact_list[index][1], ),
                          trailing: Icon(Icons.phone_forwarded),
                          onTap: ()  {
                            _makePhoneCall(contact_list[index][2]);

                          },
                        ),
                      ),
                    ),
                childCount: 4),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 140.h,
            ),
          )

        ],
      ),
    );
  }
}
