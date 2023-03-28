import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import '../widgets/user_products_items.dart';
import '../providers/products.dart';

class userproductsscreen extends StatelessWidget {
  static const routeNamed = '/userproductsscreen';

  Future <void> _refreshproducts (BuildContext ctx) async{
    return await Provider.of<products>(ctx).getandsetproducts();
  } 
  //const userproductsscreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final proddata = Provider.of<products>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      //backgroundColor: Colors.black,
      appBar: AppBar(

       // backgroundColor: Theme.of(context).accentColor,
       //backgroundColor: Color.fromRGBO(163, 26, 203, 1),
       backgroundColor: Colors.black,
       title: Text('Manage Products', style: TextStyle(color: Colors.white),),
        actions: [IconButton(onPressed: () {
          Navigator.of(context).pushNamed(editproductscreen.RouteNamed);
        }, icon: Icon(Icons.add))],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: (() => _refreshproducts(context)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemBuilder: (ctx, i) => Column(
      
                children: [
                  userproducts(
                      proddata.items[i].imageurl, proddata.items[i].title,proddata.items[i].id),
                      Divider(),
                ],
              ),
                  itemCount: proddata.items.length,
                  ),
        ),
      ),
    );
  }
}
