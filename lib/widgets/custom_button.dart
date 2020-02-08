import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color color;
  final Color textColor;
  final Color borderColor;

  CustomButtom(
      {@required this.onPressed,
      @required this.buttonText,
      this.borderColor = Colors.transparent,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Text(this.buttonText),
      color: this.color,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: this.borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(14.0),
      textColor: this.textColor,
    );
  }
}
