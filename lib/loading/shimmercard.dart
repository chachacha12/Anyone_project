import 'package:anyone/loading/shimmercomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

///food drink 박스들 사이즈의 로딩박스 하나
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(5.w, 0.h, 0.w, 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           //SizedBox(height: 20.h),
           //ShimmerComponent.rectangular(height: 160.h),
           //SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ShimmerComponent.rectangular(height: 140.h, width: 135.w),

            ],
          )
        ],
      ),
    );
  }
}


///whats up 컨텐츠 박스 사이즈의 로딩박스
class ShimmerCard2 extends StatelessWidget {
  const ShimmerCard2({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 0.h),
      child: ShimmerComponent.rectangular(height: 180.h, width: 300.w),
    );
  }
}


///culture 컨텐츠 박스 사이즈의 로딩박스
class ShimmerCard3 extends StatelessWidget {
  const ShimmerCard3({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ShimmerComponent.rectangular(height: 250.h),
          SizedBox(height: 5.h,),
          ShimmerComponent.rectangular(height: 10.w, width: 180.h,)
        ],
      ),
    );
  }
}

///동아리 컨텐츠 박스 사이즈의 로딩박스
class ShimmerCard4 extends StatelessWidget {
  const ShimmerCard4({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding:  EdgeInsets.fromLTRB(0.w, 0.h, 0.w, 0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h,),
            ShimmerComponent.rectangular(height: 45.h, width: 310.w),
          ],
        ),
      ),
    );
  }
}