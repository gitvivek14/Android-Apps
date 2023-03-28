import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import '../providers/product.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/019 badge.dart';
import '../providers/cart.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

enum filteroptions {
  Favourites,
  All,
}


class product_overview_screen extends StatefulWidget {
  @override
  State<product_overview_screen> createState() =>
      _product_overview_screenState();
}


class _product_overview_screenState extends State<product_overview_screen> {
  var isint = true;
 var isloading = false;
  var showonlyfav = false;
  // final List<product> laodedproducts = [
  @override
  void didChangeDependencies() {
    
    
    //runs before buildrun andruns multiple times . runs after widget has been built
    if(isint){
      setState(() {
      isloading = true;
    });
       Provider.of<products>(context).getandsetproducts().then((value) {
        setState(() {
          isloading = false;
        });
       });

    }
    isint= false;
   
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      
      appBar: AppBar(
        elevation: 20,
        bottomOpacity: 80,
        title: Text('Shopping Complex'),
    //     gradient: LinearGradient(
    // colors: [
    //   Color.fromRGBO(57, 38, 157, 100),
    //   Color.fromRGBO(181, 123, 238, 100),
      
      
    // ],),
        backgroundColor: Theme.of(context).accentColor,
        actions: [
          PopupMenuButton(
              onSelected: (filteroptions selectedvalue) {
                setState(() {
                  if (selectedvalue == filteroptions.Favourites) {
                    showonlyfav = true;
                  } else {
                    showonlyfav = false;
                  }
                });
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text('Show Favourites'),
                      value: filteroptions.Favourites,
                    ),
                    PopupMenuItem(
                      child: Text('Show All'),
                      value: filteroptions.All,
                    )
                  ]),
          Consumer<cart>(
              builder: (_, cart, _2) => Badge(
                    child: IconButton(icon: Icon(Icons.shopping_cart_checkout,),
                     onPressed: (() => Navigator.of(context).pushNamed(cartscreen.routeNamed))),
                    value: cart.itemcount.toString(),
                  )),
        ],
        ),
        drawer: AppDrawer(),
      
      body: isloading? Center(child: CircularProgressIndicator(color: Colors.greenAccent),)  :GridViewBuild(showonlyfav),
      
    );
  }
}
