import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
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
          backgroundColor:
              MaterialStateProperty.all<Color>(const Color(0XFF327C04)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ))),
      onPressed: onPressed,
      child: Text(
        title!,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white),
      ),
    );
  }
}
