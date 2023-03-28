import 'package:flutter/foundation.dart';

class Cartitem {
  final String id;
  final String title;
  final double price;
  final int quantity;

  Cartitem(
      {@required this.id,
      @required this.price,
      @required this.quantity,
      @required this.title});
}

class cart with ChangeNotifier {
  Map<String, Cartitem> _items ={};

  Map<String, Cartitem> get items {
    return {..._items};
  }
  int get itemcount{
    return  _items.length;
  }
  double get totalamt{
    double total  = 0.0;
    _items.forEach((key, value) { 
      total+= value.price*value.quantity;
    });
    return total;
  }
  void removeitem(String prodid){
    _items.remove(prodid);
    notifyListeners();
  }
  void delsingleitem(String prodid){
    if(!_items.containsKey(prodid)){
      return;
    }
    if(_items[prodid].quantity>1){
      _items.update(prodid, (existing) => Cartitem(id: existing.id, price: existing.price, quantity: existing.quantity-1, title: existing.title));
    }else{
      _items.remove(prodid);
    }
    notifyListeners();

  }
  void cleaner(){
    _items = {};
    notifyListeners();
  }



  void additems(String prodid, String title, double price) {
    if (_items.containsKey(prodid)) {
      _items.update(
          prodid,
          (value) => Cartitem(
              id: value.id,
              price: value.price,
              quantity: value.quantity + 1,
              title: value.title));
    } else {
      _items.putIfAbsent(
          prodid,
          () => Cartitem(
              id: DateTime.now().toString(),
              price: price,
              title: title,
              quantity: 1));
    }
    notifyListeners();
  }
}
