
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/cart_screen.dart';
import '../providers/products.dart';
import'../providers/cart.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ProductDetail extends StatelessWidget {
  static const routeNamed = '/productdetailscreen';

  // final String title;
  // ProductDetail(this.title);
  //ProductDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context).settings.arguments as String;
    final loadedproduct = Provider.of<products>(context).findbyid(productid);
     final Cart = Provider.of<cart>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(loadedproduct.title),
    //     gradient: LinearGradient(
    // colors: [
    //   Colors.purpleAccent,
    //   Colors.indigo,
    // ],),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Card(
          color: Colors.greenAccent,
          shadowColor: Colors.greenAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 10,
          margin: EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              loadedproduct.imageurl,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          elevation: 10,
          //margin: EdgeInsets.all(15),
          color: Colors.greenAccent,
          child: Text('Price : ' + '₹' + loadedproduct.price.toString(),
              style: TextStyle(fontSize: 20),
              softWrap: true,
              textAlign: TextAlign.center),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'Description',
          style: TextStyle(
              color: Color.fromARGB(255, 239, 241, 236), fontSize: 20),
          softWrap: true,
        ),
        SizedBox(
          height: 10,
        ),
        Card(
          elevation: 10,
          shadowColor: Colors.lightGreen,
          color: Colors.greenAccent,
          child: Text(
            loadedproduct.description,
            style: TextStyle(fontSize: 18),
            softWrap: true,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor)),
                onPressed: () => Navigator.of(context).pushNamed(cartscreen.routeNamed),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart),
                    Text('Show Cart'),
                  ],
                )),
            // SizedBox(
            //   height: 56,
            //   width: 56,
            //   //size: sizeOf(56,56),
            //   child: ClipOval(
            //     child: Material(
            //       color: Colors.orangeAccent,
            //       child: InkWell(
            //         splashColor: Colors.green,
            //         onTap: () {},
            //         child: Column(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             children: <Widget>[
            //               InkWell(
            //                   onTap: () => Navigator.of(context)
            //                       .pushNamed(cartscreen.routeNamed),
            //                   child: Icon(
            //                     Icons.shopping_cart,
            //                     color: Colors.black,
            //                   )), // <-- Icon
            //               Text("Buy"),
            //             ]),
            //       ),
            //     ),
            //   ),
            // ),
            ElevatedButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Theme.of(context).accentColor)),
                onPressed: () => Cart.additems(loadedproduct.id, loadedproduct.title, loadedproduct.price),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_cart_checkout),
                    Text('Add to Cart'),
                  ],
                )),
          ],
        ),
      ])),
    );
  }
}
