import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/order_item.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import '../widgets/order_item.dart';
//import 'package:new_gradient_app_bar/';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class orderscreen extends StatefulWidget {
  static const routeNamed = '/orders';

  @override
  State<orderscreen> createState() => _orderscreenState();
}

class _orderscreenState extends State<orderscreen> {
  var _isloading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) async {
      setState(() {
        _isloading = true;
      });
      await Provider.of<orders>(context , listen: false).Fetchandsetorders();
      setState(() {
        _isloading = false;
      });

    });
    // TODO: implement initState
    super.initState();
  }
  //const orderscreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final orderdata = Provider.of<orders>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar:  AppBar(
        backgroundColor: Theme.of(context).accentColor,
    //     gradient: LinearGradient(
    // colors: [
    // Color.fromRGBO(57, 38, 157, 100),
    //   Color.fromRGBO(181, 123, 238, 100),
    // ],),
          title: Text(' Your Orders'),
          elevation: 6,
      ),
      drawer: AppDrawer(),
      body: Column(children: [
        Expanded(
          child: _isloading? Center(child: CircularProgressIndicator(),):
          ListView.builder(
            itemBuilder: (ctx, index) => Orderitem(orderdata.ordersget[index]),
            itemCount: orderdata.ordersget.length,
          ),
        )
      ]),
    );
  }
}
