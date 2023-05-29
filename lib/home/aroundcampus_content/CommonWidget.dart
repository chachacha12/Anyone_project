import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Extend_HeroImage.dart';

///어라운드캠퍼스 페이지들중에 공통으로 들어가는 위젯들은 이곳에서 불러서 사용하기 위함 - 재사용성, 변경가능성 향상에 도움


///컨텐츠의 제목, 가게명
contentsName(name){
  return Container(
    margin: EdgeInsets.fromLTRB(
        10.w, 0.h, 7.w, 0.h),
    child: Text(    ///줄바꿈이 파베 firestore에선 되지않아서 여기서 줄바꿈을 해준후 보여주기위함.
      name.toString().replaceAll(
          "\\n", "\n"),
      style: TextStyle(
          color: Color(0xff397D54),
          fontSize: 14.sp,
          fontWeight: FontWeight.bold
      ),),
  );
}

///찜하기 버튼
myListButton(isMyList){
  return Container(
    margin: EdgeInsets.fromLTRB(10.w, 0.h, 0.w, 0.h),
    padding: EdgeInsets.all(3.h),
    decoration: BoxDecoration(

        color: isMyList
            ? Color(0xffFF8BA0)
            : Colors.black12,

        borderRadius: BorderRadius.all(
            Radius.circular(
                4.r))),
    child:isMyList? Icon(Icons.favorite, color: Colors.white, size: 15.h,) :
    Icon(Icons.favorite, color: Colors.white, size: 15.h,  ),
  );
}

///view more버튼
moreButton(){
  return Row(
    //mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
        padding: EdgeInsets.fromLTRB(
            5.w,15.h, 0.w, 0.h),
        child: Text('view more', textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 13.sp,
            color: Color(0xff397D54),
            fontWeight: FontWeight.w600,
          ),),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(
            0.w, 15.h, 0.w, 0.h),
        child: Icon(Icons.chevron_right, size: 18.sp,
          color: Color(0xff397D54),
        ),
      )
    ],
  );
}


///문서하나안의 이미지들 수평리스트로 띄워주는 함수
getImageList(doc){
  return  Container(
    margin: EdgeInsets.fromLTRB(0.w, 5.h, 0.w, 0.w),
    height: 150.0.h,
    child: ListView.builder( //이미지들 수평리스트로 보여줌
        scrollDirection: Axis.horizontal,
        itemCount: doc['imagepath']
            .length,
        itemBuilder: (context, index2) {
          return SizedBox(
            width: 150.0.w,
            child: Card(
              child: GestureDetector( //클릭스 히어로위젯을 통해 이미지 하나만 확대해서 보여줌
                child: Hero(
                  tag: doc['imagepath'][index2],
                  child: Image.network(
                    doc['imagepath'][index2],
                    fit: BoxFit.cover,),
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) =>
                          Extend_HeroImage(
                              doc['imagepath'],
                              index2)));
                },
              ),
            ),
          );
        }),
  );
}

///찜목록페이지에서 쓰는 위젯. 찜목록 없을때는 이 박스 띄워줌
getEmptyList(){
  return Container(
    alignment: Alignment.center,
    child: Text(
      'Press the Like button on the OFF campus,''\n''Try to make your own favorite list',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 13.sp,
        color: Color(0xff706F6F),
      ),
    ),
  );
}















