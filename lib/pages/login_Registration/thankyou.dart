import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Thankyou extends StatefulWidget {
  const Thankyou({Key? key}) : super(key: key);

  @override
  State<Thankyou> createState() => _ThankyouState();
}

class _ThankyouState extends State<Thankyou> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () => Get.toNamed('/login'));
    return Scaffold(
      body: Container(
        color: const Color(0xFFF7F9EA),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Thankyou for \nregistering with us",
                      style: TextStyle(
                          fontSize: 50,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 500,
                      child: Divider(
                        thickness: 2,
                        color: Color(0xFF327C04),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "An Email will be sent to you shortly",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.asset(
                "assets/images/agromatelogonew.png",
                height: 235,
                width: 293,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
