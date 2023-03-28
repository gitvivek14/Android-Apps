import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class product with ChangeNotifier {
  final String id;
  final String title;
  final String imageurl;
  final String description;
  final double price;
  bool isfavourite;

  product(
      {@required this.id,
      @required this.title,
      this.imageurl,
      this.description,
      this.isfavourite = false,
      @required this.price});


      Future<void>  togglefavourite() async{
        final url2 =
        'https://flutter-33e0d-default-rtdb.firebaseio.com/products/$id.json';
        var oldstatus = isfavourite;
         isfavourite = !isfavourite;
        notifyListeners();
        try{
          final response = await http.patch(url2 , body: json.encode({
          'isFavourite' : isfavourite,
        }));
        if(response.statusCode>=400){
          isfavourite = oldstatus;
          notifyListeners();

        }

        }catch(error){
          isfavourite = oldstatus;
          notifyListeners();
        }
        

       
      }
}
