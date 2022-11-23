import 'package:flutter/material.dart';
import 'package:flutter_agro_new/component/top_bar.dart';

class StockOrder extends StatefulWidget {
  const StockOrder({Key? key}) : super(key: key);

  @override
  State<StockOrder> createState() => _StockOrderState();
}

class _StockOrderState extends State<StockOrder> {
  @override
  Widget build(BuildContext context) {
    return Text("Order");
  }
}
