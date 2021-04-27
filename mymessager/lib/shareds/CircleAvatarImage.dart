import 'package:flutter/material.dart';

class CircleAvatarImage extends StatelessWidget {
  final String ulrImage;

  const CircleAvatarImage({Key key, this.ulrImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(360),
      child: FadeInImage.assetNetwork(
        width: 60,
        height: 60,
        placeholder: 'lib/res/images/loading_image.gif',
        image: ulrImage,
      ),
    );
  }
}
