import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  final bool obscureText;
  final TextEditingController textEditingController;
  final String hintText;
  final String labelText;
  final IconData iconData;
  final void Function() onPress;

  const InputTextFieldWidget(
      {Key key,
      this.obscureText = false,
      this.textEditingController,
      this.hintText,
      this.labelText,
      this.iconData,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: textEditingController,
      cursorColor: Colors.red,
      decoration: InputDecoration(
        suffixIcon: IconButton(icon: Icon(iconData), onPressed: onPress),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 18),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18))),
      ),
    );
  }
}
