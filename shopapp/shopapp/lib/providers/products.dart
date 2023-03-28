import 'package:flutter/material.dart';
import 'product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class products with ChangeNotifier {
  List<product> _items = [
    // product(
    //     id: 'p1',
    //     title: 'Red-Tshirt',
    //     description:
    //         'For a long time in web design, a white background was considered the only way to create empty space in app design.',
    //     price: 250,
    //     imageurl:
    //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg'),
    // product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageurl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageurl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageurl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  // var showfav = false;
  List<product> get items {
    return [..._items];
  }

  List<product> get favouriteitems {
    return _items.where((element) => element.isfavourite).toList();
  }

  product findbyid(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  // void showfavonly(){
  //   showfav=true;
  // }
  // void showall(){
  //   showfav=false;
  // }

  Future<void> getandsetproducts() async {
    const url2 =
        'https://flutter-33e0d-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(url2);
      final extractedata = json.decode(response.body) as Map<String, dynamic>;
      final List<product> laodedproducts = [];
      extractedata.forEach((prodid, proddata) {
        laodedproducts.add(product(
            id: prodid,
            title: proddata['title'],
            description: proddata['description'],
            price: proddata['price'],
            imageurl: proddata['imageurl'],
            isfavourite: proddata['isFavourite']));
      });
      _items = laodedproducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addproduct(product productor) async {
    var url1 =
        'https://flutter-33e0d-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(url1,
          body: json.encode({
            'title': productor.title,
            'price': productor.price,
            'description': productor.description,
            'imageurl': productor.imageurl,
            'isFavourite': productor.isfavourite,
          }));
      final newproduct = product(
        id: json.decode(response.body)['name'],
        price: productor.price,
        title: productor.title,
        description: productor.description,
        imageurl: productor.description,
      );
      _items.add(newproduct);
      //_items.add(value);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  //   var url = Uri.https('https://console.firebase.google.com/u/0/project/flutter-33e0d/database/flutter-33e0d-default-rtdb/data/~2F','/products.json');
  //   http.post(url, body: json.encode({
  //     'title':productor.title,
  //     'price':productor.price,
  //     'description':productor.description,
  //     'imageurl':productor.imageurl,
  //     'isFavourite':productor.isfavourite

  //   })).then((value) {
  //      final newproduct = product(
  //       id: json.decode(value.body),
  //       price: productor.price,
  //       title: productor.title,
  //       description: productor.description,
  //       imageurl: productor.description,
  //       );
  //       _items.add(newproduct);
  //   //_items.add(value);
  //   notifyListeners();
  // });

  //   final newproduct = product(
  //       id: DateTime.now().toString(),
  //       price: productor.price,
  //       title: productor.title,
  //       description: productor.description,
  //       imageurl: productor.description);
  //       _items.add(newproduct);

  //   //_items.add(value);
  //   notifyListeners();
  // }

  Future<void> updateproduct(String id, product newprod) async {
    final url2 =
        'https://flutter-33e0d-default-rtdb.firebaseio.com/products/$id.json';

    final prodindex = _items.indexWhere((element) => element.id == id);
    if (prodindex >= 0) {
      await http.patch(url2,
          body: json.encode({
            'title': newprod.title,
            'description': newprod.description,
            'imageurl': newprod.imageurl,
            'price ': newprod.price,
          }));
      _items[prodindex] = newprod;
      notifyListeners();
    }
  }

  void delprod(String id) {
    final url2 =
        'https://flutter-33e0d-default-rtdb.firebaseio.com/products/$id.json';
    final existingindex = _items.indexWhere((element) => element.id == id);
    var existingdata = _items[existingindex];
    _items.removeAt(existingindex);
    http.delete(url2).then((value) {
      existingdata = null;
    }).catchError(() {
      _items.insert(existingindex, existingdata);
    });

    // _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
