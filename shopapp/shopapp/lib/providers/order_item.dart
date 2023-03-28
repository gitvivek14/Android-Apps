

import 'package:flutter/material.dart';
import 'package:shopapp/widgets/cart_item.dart';
import 'cart.dart';
import 'package:http/http.dart ' as http;
import 'dart:convert';

import './cart.dart';

class orderitem {
  final String id;
  final double amt;
  final List<Cartitem> products;
  final DateTime date;
  orderitem({this.id, this.amt, this.products, this.date});
}

class orders with ChangeNotifier {
  List<orderitem> _orders = [];

  List<orderitem> get ordersget {
    return [..._orders];
  }

  Future<void> Fetchandsetorders() async {
    const url =
        'https://flutter-33e0d-default-rtdb.firebaseio.com/orders/.json';
    final response = await http.get(url);
    final List<orderitem> loadeddata = [];
    final extracteddata = json.decode(response.body) as Map<String, dynamic>;
    extracteddata.forEach((ordrid, ordrdata) {
      loadeddata.add(orderitem(
          id: ordrid,
          amt: ordrdata['amount'],
          date: DateTime.parse(ordrdata['Date']),
          products: (ordrdata['products'] as List<dynamic>)
              .map((e) => Cartitem(
                  price: e['price'],
                  id: e['id'],
                  quantity: e['quantity'],
                  title: e['title'],
                  ))
              .toList()));
    });
    _orders = loadeddata.reversed.toList();
    notifyListeners();


    //print(json.decode(response.body));
  }

  Future<void> addorders(double amt, List<Cartitem> cartprodu) async {
    final timestamp = DateTime.now();
    const url =
        'https://flutter-33e0d-default-rtdb.firebaseio.com/orders/.json';
    final response = await http.post(url,
        body: json.encode({
          'amount': amt,
          'Date': timestamp.toIso8601String(),
          'products': cartprodu
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price,
                  })
              .toList(),
        }));
    _orders.insert(
        0,
        orderitem(
            amt: amt,
            date: DateTime.now(),
            id: json.decode(response.body)['name'],
            products: cartprodu));
    notifyListeners();
  }
}
