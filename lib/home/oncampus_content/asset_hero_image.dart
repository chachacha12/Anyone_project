import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';


class Asset_hero_image extends StatelessWidget {
  Asset_hero_image(this.Imagepath, {Key? key}) : super(key: key);
  final Imagepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView(
            heroAttributes: PhotoViewHeroAttributes(tag: Imagepath),
            imageProvider: AssetImage(Imagepath),
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

/*
 IconButton(
              iconSize: 10.w,
              icon: Icon(Icons.cancel),
              onPressed: (){

              },
            )


            TextButton(
              child: Text('aefaaefa'),
              onPressed: (){

              },
            )
 */