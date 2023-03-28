import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';

class cartitem extends StatelessWidget {
  final String prodid;
  final String id;
  final double price;
  final int quantity;
  final String title;
  //final String url;
  cartitem(this.price, this.id, this.quantity, this.title,this.prodid);
  // const cartitem({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(context: context, builder: (ctx)=> AlertDialog(
          title: Text('Are you Sure? '),
          content: Text('Do you Want to remove the item from the Cart ?'),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop(false);
            }, child: Text('No')),
            TextButton(onPressed: (){
              Navigator.of(context).pop(true);
            }, child: Text('Yes')),
          ],
        )

        );
      },
      onDismissed: (direction){
        Provider.of<cart>(context, listen: false).removeitem(prodid);

      },
      key: ValueKey(id),
      background: Container(
          color: Theme.of(context).errorColor,
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.only(right: 20),
          alignment: Alignment.centerRight,
          child: 
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          ),
      child: Card(
        color: Colors.orangeAccent,
        margin: EdgeInsets.all(10),
        elevation: 10,
        shadowColor: Theme.of(context).accentColor,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Padding(
                padding: EdgeInsets.all(5),
                child: FittedBox(child: Text('₹' + price.toString()))),
          ),

          title: Text(title),
          subtitle: Text('Total : ${(price * quantity)}'),
          trailing: Text(quantity.toString()),
        ),
      ),
    );
  }
}
