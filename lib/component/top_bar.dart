import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Container(
      height: 42,
      decoration: const BoxDecoration(
        color: Colors.orange,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0.8,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            child: Container(
              height: double.maxFinite,
              color: Colors.orange[300],
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text('Dashboard'),
            ),
          ),
          Text('Task'),
          Text('Crop Plans'),
          Text('Crop'),
          Text('Farms'),
          Text('Inventory'),
          Text('Growth Stage'),
          Text('GAP Analysis'),
          Text('User'),
          Text('Allocation'),
        ],
      ),
    ));
  }
}
