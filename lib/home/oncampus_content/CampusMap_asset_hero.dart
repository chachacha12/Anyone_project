import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';


class CampusMap_asset_hero_image extends StatelessWidget {
  CampusMap_asset_hero_image(this.Imagepath, {Key? key}) : super(key: key);
  final Imagepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            heroAttributes: PhotoViewHeroAttributes(tag: Imagepath),
            imageProvider: AssetImage(Imagepath),  //에셋 이미지로 히어로위젯 띄워줌. 얘만.
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
