import 'package:flutter/material.dart';
import 'package:shopapp/providers/products.dart';
import '../providers/product.dart';
import 'product_item.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
class GridViewBuild extends StatelessWidget {
  final bool showfavs;
  GridViewBuild(this.showfavs);
  @override
  Widget build(BuildContext context) {
    final productsdata =  Provider.of<products>(context);
    final productsd = showfavs? productsdata.favouriteitems:productsdata.items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) {
        return   ChangeNotifierProvider.value(value : productsd[index],
          child: productitem(
            // id: productsd[index].id,
            // imageurl: productsd[index].imageurl,
            // price: productsd[index].price,
            // title: productsd[index].title)
            ),
            ); 
      },
      itemCount: productsd.length,
    );
  }
}