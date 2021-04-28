import 'package:flutter/material.dart';

class CircleAvatarImage extends StatelessWidget {
  final String ulrImage;
  final double width;
  final double height;

  const CircleAvatarImage({Key key, this.ulrImage, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(360),
      child: FadeInImage.assetNetwork(
        width: width,
        height: height,
        placeholder: 'lib/res/images/loading_image.gif',
        image: ulrImage,
      ),
    );
  }
}
