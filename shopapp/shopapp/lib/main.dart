//VivekArora_102203778
import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/order_item.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/product_overview_screen.dart';
import 'package:shopapp/screens/user_products_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';
import './screens/admin_intro.dart';


void main() {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  //const Myapp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((ctx) => products()),
        ),
        ChangeNotifierProvider(create: ((ctx) => cart())),
        ChangeNotifierProvider(create: (ctx)=> orders()),
        
      ],
      child: MaterialApp(
        home: product_overview_screen(),
        routes: {
          ProductDetail.routeNamed: (ctx) {
            return ProductDetail();
          },
          cartscreen.routeNamed:(ctx){
            return cartscreen();
          },
          orderscreen.routeNamed:(ctx){
            return orderscreen();
          },
          userproductsscreen.routeNamed:(ctx){
            return userproductsscreen();
          },
          editproductscreen.RouteNamed:(ctx){
            return editproductscreen();
          },
          admin.routeNamed:(ctx){
            return admin();
          }
        },
        debugShowCheckedModeBanner: false,
        title: 'SHOPAPP',
        theme: ThemeData(
            primaryColor: Colors.black,
            accentColor: Colors.deepPurpleAccent[400],
            errorColor: Colors.redAccent,
            fontFamily: 'Lato'),
      ),
    );
  }
}
