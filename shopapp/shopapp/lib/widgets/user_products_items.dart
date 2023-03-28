import 'package:flutter/material.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class userproducts extends StatelessWidget {
  final String title;
  final String imageurl;
  final String id;
  userproducts(this.imageurl, this.title,this.id);
  //const userproducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      
      selectedTileColor: Colors.orangeAccent,
      title: Text(title , style: TextStyle(color: Colors.white),),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),),
        trailing: Container(
          width: 100,
          child: Row(children: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamed(editproductscreen.RouteNamed , arguments: id);
            }, icon: Icon(Icons.edit , color: Colors.blue,), color: Theme.of(context).accentColor,),
            IconButton(onPressed: (){
              Provider.of<products>(context,listen: false).delprod(id);

            }, icon: Icon(Icons.delete , color: Colors.redAccent,), color: Theme.of(context).errorColor,),
          ]),
        ),
        //tileColor: Color.fromRGBO(117, 240, 215, 1),
        tileColor: Color.fromRGBO(198, 62, 182, 1),
        
      
      );

    
  }
}
