import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

//사진 이미지 클릭시 하나의 이미지 전체화면으로 나오고 줌인해서 볼 수 있게 해주는 위젯
class Extend_HeroImage extends StatelessWidget {
  Extend_HeroImage(this.Imagepath, {Key? key}) : super(key: key);
  final Imagepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            heroAttributes: PhotoViewHeroAttributes(tag: Imagepath),
            imageProvider: NetworkImage(Imagepath),
          ),
          Positioned(
              top: 30.h,
              right: 13.w,
              child: IconButton(
                iconSize: 25.w,
                color: Colors.white,
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
          )
        ],
      ),
    );

  }
}
