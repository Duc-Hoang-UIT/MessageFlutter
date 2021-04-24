import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final IconData iconData;
  final void Function() onPressed;

  const CustomButton({Key key, this.label, this.iconData, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.blue[300],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              side: BorderSide(color: Colors.red[200])),
        ),
        onPressed: () {
          onPressed();
        },
        icon: Icon(iconData),
        label: Text("$label"));
  }
}
