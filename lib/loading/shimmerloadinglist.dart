import 'package:anyone/loading/shimmercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///tips의 박스들 크기정도의 3개 박스들 로딩중일때
class ShimmerLoadingList extends StatelessWidget {
  const ShimmerLoadingList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(5.w),
      height: 200.0.h,
      child: ListView.builder( //이미지들 수평리스트로 보여줌
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) {
            return ShimmerCard();
          }),
    );

  }
}
