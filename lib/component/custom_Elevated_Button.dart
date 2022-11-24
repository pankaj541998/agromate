import 'package:flutter/material.dart';

class customElevatedButton extends StatelessWidget {
  const customElevatedButton({
    Key? key,
    this.title,
    required this.onPressed,
  }) : super(key: key);
  final String? title;
  final dynamic onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(Color(0XFF327C04)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ))),
      onPressed: onPressed,
      child: Text(
        title!,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
      ),
    );
  }
}
