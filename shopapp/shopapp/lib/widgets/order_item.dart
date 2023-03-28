import 'dart:ui';

import 'package:flutter/material.dart';
import '../providers/order_item.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';

class Orderitem extends StatefulWidget {
  final ord.orderitem order;
  Orderitem(this.order);

  @override
  State<Orderitem> createState() => _OrderitemState();
}

class _OrderitemState extends State<Orderitem> {
  var expanded = false;
  //const Orderitem({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 20,
      shadowColor: Colors.green,
      color: Color.fromARGB(255, 85, 222, 155),
      child: Column(
        children: [
          ListTile(
              title: Text(
                widget.order.amt.toString(),
                style: TextStyle(color: Color.fromARGB(255, 10, 9, 9)),
              ),
              subtitle: Text(
                DateFormat.yMd().format(widget.order.date),
                style: TextStyle(color: Color.fromARGB(255, 23, 19, 19)),
              ),
              trailing: IconButton(
                icon: Icon( expanded? Icons.expand_less :   Icons.expand_more),
                onPressed: () {
                  setState(() {
                    expanded=!expanded;
                  });
                },
              )
              ),
          if(expanded)
          Container(
            height: min(widget.order.products.length*20.0+10, 100),
            //color: Color.fromARGB(255, 61, 255, 7),
            color: Colors.orangeAccent,
            //decoration: BoxDecoration(gradient: LinearGradient(begin:Alignment.topRight, end: Alignment.bottomLeft,colors: [Colors.yellow,
                // Colors.purpleAccent,
                // Colors.greenAccent,
                // Colors.orangeAccent,])),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            child: ListView(children: widget.order.products.map((e) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(e.title , style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                ),
              Text(
                                '${e.quantity}x ₹${e.price}',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 3, 3, 3),
                                ),
                              )
            ],)).toList(),


            ),

          ),
        ],
      ),
    );
  }
}
