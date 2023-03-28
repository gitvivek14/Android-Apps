import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart';
import '../providers/order_item.dart';

class cartscreen extends StatelessWidget {
  static const routeNamed = '/cart';
  const cartscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart = Provider.of<cart>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Your Cart'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(children: [
        Card(
          elevation: 6,
          color: Theme.of(context).accentColor,
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Spacer(),
                  Chip(
                    label: Text('₹${Cart.totalamt.toStringAsFixed(2)}',
                        style: TextStyle(color: Color.fromARGB(255, 0, 0, 0))),
                    backgroundColor: Colors.greenAccent,
                  ),
                  OrderButton(Cart: Cart),
                ]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (ctx, index) => cartitem(
              Cart.items.values.toList()[index].price,
              Cart.items.values.toList()[index].id,
              Cart.items.values.toList()[index].quantity,
              Cart.items.values.toList()[index].title,
              Cart.items.keys.toList()[index]),
          itemCount: Cart.items.length,
        )),
      ]),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.Cart,
  }) : super(key: key);

  final cart Cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isloading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: isloading? CircularProgressIndicator():
      Text(
        'Order Now',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color.fromARGB(255, 255, 255, 255)),
      ),
      onPressed: (widget.Cart.totalamt<=0 || isloading)? null :
      () async {
        setState(() {
          isloading=true;
        });
        await Provider.of<orders>(context , listen: false)
            .addorders(widget.Cart.totalamt, widget.Cart.items.values.toList());
            setState(() {
              isloading = false;
            });
        widget.Cart.cleaner();
      },
    );
  }
}
