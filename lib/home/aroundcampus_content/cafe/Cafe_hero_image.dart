import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

class Cafe_hero_image extends StatelessWidget {
  Cafe_hero_image(this.Imagepath, {Key? key}) : super(key: key);
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
              top: 5.h,
              right: 5.w,
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
