import 'package:anyone/loading/shimmercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShimmerLoadingList extends StatelessWidget {
  const ShimmerLoadingList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0.w, 5.h, 0.w, 0.w),
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
