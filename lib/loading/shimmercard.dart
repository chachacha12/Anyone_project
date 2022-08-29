import 'package:anyone/loading/shimmercomponent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

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
              ShimmerComponent.rectangular(height: 140.h, width: 140.w),

              /*
               ShimmerComponent.circular(width: 50.w, height: 50.h),
               SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    ShimmerComponent.rectangular(
                      height: 20.h,
                      width: 100.w,
                    ),
                    SizedBox(height: 8.h),
                    ShimmerComponent.rectangular(height: 20.h, width: 180.w),
                  ],
                ),
              )
               */
            ],
          )
        ],
      ),
    );
  }
}
