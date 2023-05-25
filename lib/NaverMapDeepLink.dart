import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

//어라운드캠퍼스 컨텐츠들중 네이버맵 클릭시 네이버맵 실행시키는 커스텀 위젯임
//네이버맵 url scheme값을 이용해서 특정 장소 검색하는 페이지 이동하는 딥링크 실행
//각 컨텐츠들의 제목값을 state로 전달받아서 여기서 네이버맵 검색에 사용함
class NaverMapDeepLink extends StatelessWidget {
  NaverMapDeepLink({Key? key, this.titlename}) : super(key: key);
  final titlename;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text('Naver Map', style:
      TextStyle(fontSize: 14.sp,
          color: Color(0xff73C088),
          fontWeight: FontWeight.w400),),
      onTap: () async { //네이버지도url scheme을 이용한 딥링크임. 네이버지도앱 실행시켜줄.


        //식당명 풀네임에서 괄호속의 한글값들만 가져와서 네이버맵으로 검색하기 위함
        var map_search_array = titlename.split('(');
        var map_search_word = map_search_array[1].replaceAll(')','');

        //네이버지도앱의 url scheme값을 이용해서 딥링크 만듬
        var url = Uri.parse(
            "nmap://search?query=" +
                map_search_word +
                " 건대점" +
                "&appname=com.leecha.anyone");

        if (await canLaunchUrl(url)) { //네이버 지도앱 있을시
          await launchUrl(url);
        } else {  //네이버지도앱이 없을시
          Fluttertoast.showToast(
            msg: "Download <Naver Map> Application",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            //fontSize: 20,
            //textColor: Colors.white,
            //backgroundColor: Colors.redAccent
          );
          //os기기별로 예외처리해줌
          if (Platform.isAndroid) {  //안드로이드폰일때
            print("이것은 안드로이드폰!");
            //구글플레이앱 바로 실행시켜서 네이버지도검색결과 보여줌
            // market:// 이건 구글플레이앱의 url scheme값임 (메니페스트파일에 등록해줘야함 )
            var url = Uri.parse("market://details?id=com.nhn.android.nmap");
            if(await canLaunchUrl(url)){ //구글플레이 네이버지도링크로 이동가능할때
              await launchUrl(url);
            }else{
              throw 'Cannot move to googleplay link !!';
            }
          } else if (Platform.isIOS) {   //아이폰일때
            print("이것은 아이폰!");
            //앱스토어 바로가는 url schem값과 네이버지도 id값. 넣어서 앱스토어 바로 실행 후 네이버지도 다운로드페이지 보여줌
            //itms-apps는 앱스토어의 url scheme값임 (info.plist에 등록해줘야함)
            var url = Uri.parse("itms-apps://itunes.apple.com/app/id311867728");
            if(await canLaunchUrl(url)){ //앱스토어 네이버지도링크로 이동가능할때
              await launchUrl(url);
            }else{
              throw 'Cannot move to appstore link !!';
            }
          }else{   //안드, 아이폰 둘 다 아닐때
            throw 'this is not aos, ios !!!!!';
          }
        }
      },
    );
  }
}
