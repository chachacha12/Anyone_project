import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';


class Fashion_hero_image extends StatelessWidget {
  Fashion_hero_image(this.Imagepath, {Key? key}) : super(key: key);
  final Imagepath;

  @override
  Widget build(BuildContext context) {
    return PhotoView(
      heroAttributes: PhotoViewHeroAttributes(tag: Imagepath),
      imageProvider: NetworkImage(Imagepath),
    );
  }
}
