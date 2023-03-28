import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../screens/product_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/product.dart';
import '../providers/cart.dart';

class productitem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageurl;
  // final double price;

  // productitem({this.id, this.imageurl, this.title, this.price});

  //const productitem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productr = Provider.of<product>(context);
    final Cart = Provider.of<cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(ProductDetail.routeNamed, arguments: productr.id);
            },
            child: Image.network(
              productr.imageurl,
              fit: BoxFit.cover,
            ),
          ),
          footer: GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(
                productr.isfavourite ? Icons.favorite : Icons.favorite_border,
              ),
              onPressed: () {
                productr.togglefavourite();
              },
              color: Colors.red,
              splashColor: Colors.red,
              splashRadius: 15,
            ),
            title: FittedBox(
              //alignment: Alignment.center,
              child: Text(
                productr.title,
                textAlign: TextAlign.center,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                Cart.additems(productr.id, productr.title, productr.price);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    action: SnackBarAction(label: 'UNDO', onPressed: (){
                      Cart.delsingleitem(productr.id);
                    }),
                    content: Text('Added'),
                    duration: Duration(seconds: 2),

                    
                  ),
                );
              },
              //color: Colors.red,
              splashColor: Colors.white, splashRadius: 15,
            ),
          )),
    );
  }
}
