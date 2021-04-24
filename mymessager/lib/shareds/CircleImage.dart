import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  final String imagePath;

  const CircleImage({Key key, this.imagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          imagePath,
          height: 100,
          width: 100,
        ));
  }
}
