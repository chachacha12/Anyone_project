import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';


class Helplines extends StatelessWidget {
  Helplines({Key? key}) : super(key: key);

  //비상연락망들
  var contact_list = [
    ['Police (112)', '','112'],

    ['Fire Department/Ambulance (119)', '','119'],

    ['Konkuk University Hospital International Medical Clinic (02-2030-8361)','','02-2030-8361'],

    ['Konkuk Student Counseling Center (02-450-3019/3220)', '','02-450-3019'],

    ['Dasan Call Center (120)',
      "\n"'● provides foreigners in Seoul with informaition on living and'
          ' general administration "\n"(you can ask almost anything except for visa-related issues to this number)'"\n"''
          'available in English, Chinese, Vietnamese, Japanese, and Mongolian'"\n", '120'
    ],

    ['Korea Travel Helplines (1330)', ''
        "\n"'● one-stop helpline available as a public service for local and international travelers '
        'available in Korean, English, Japanese, Chinese, Russian, Vietnamese, Thai, or Malay'"\n", '1330'
    ],

    ['Immigration Call Center (1345)', ''
        "\n"'● call center for inquiries on vise, immigration, and other administrative and domestic services '
        'available in English, Chinese, Vietnamese, Japanese, French, Spanish, German, Russian, and 10 other languages'"\n",'1345'
    ],

    ['KCDA Call Center (1339)', ''
        "\n"'● direct call center for COVID-19 related issues available in English, Chinese, Vietnamese, Japanese, and 16 other languages'"\n", '1339'
    ],

    ['Seoul Global Center (02-2075-4180)', ''
        "\n"'● one-stop support center offering daily living, business activities, administractive services, various educational courses, '
        'and international exchange events'"\n", '02-2075-4180'
    ],
  ];

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
            'Helplines',
          ),
          ),

          //학교연락망들 보여주는 리스트
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) =>
                    Container(
                      color: Colors.white,
                      child: Card( //리스트 속 각각의 객체 하나하나임
                        elevation: 1,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 20.w),
                        child: ListTile(
                          title: Text(contact_list[index][0], style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                          )),
                          subtitle: Text(contact_list[index][1], style: TextStyle(
                              fontSize: 14.sp,
                            color: Colors.black45
                          ),),
                            trailing: Icon(Icons.phone_forwarded),
                          onTap: () {
                            _makePhoneCall(contact_list[index][2]);
                          },

                        ),
                      ),
                    ),
                childCount: 9),
          ),

          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              height: 60.h,
            ),
          )
        ],
      ),
    );
  }
}
