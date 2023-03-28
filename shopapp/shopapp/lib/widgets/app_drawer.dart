//VivekArora_102203778
import 'package:flutter/material.dart';
import 'package:shopapp/screens/admin_intro.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:shopapp/screens/user_products_screen.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Column(children: [
        NewGradientAppBar(title: Text('Hey Friend!!'),
        //backgroundColor: Theme.of(context).accentColor,
    //     gradient: SweepGradient(
    // colors: [
    //   Color.fromRGBO(57, 38, 157, 100),
    //   Color.fromRGBO(181, 123, 238, 100),
    //   //Colors.indigo,
    // ],),
        automaticallyImplyLeading: false,
        ),
        Divider(color: Colors.grey),
        ListTile(
          leading: Icon(Icons.person,color: Colors.pinkAccent),
          title: Text('Profile', style: TextStyle(color: Color.fromARGB(255, 236, 240, 236), fontSize: 15),),
          onTap: (){
            Navigator.of(context).pushNamed(admin.routeNamed);
          },
        ),
        Divider(color: Colors.grey),
        ListTile(
          leading: Icon(Icons.shop,color: Colors.greenAccent),
          title: Text('Shop', style: TextStyle(color: Color.fromARGB(255, 236, 240, 236), fontSize: 15),),
          onTap: (){
            Navigator.of(context).pushReplacementNamed('/');
          },
        ),
         Divider(color: Colors.grey,thickness: 0.7,endIndent: 10,indent: 10),
        ListTile(
          leading: Icon(Icons.payment, color: Colors.orangeAccent,),
          title: Text('Orders',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 15),),
          onTap: (){
            Navigator.of(context).pushNamed(orderscreen.routeNamed);
          },
        ),
        Divider(color: Colors.grey,thickness: 0.7,endIndent: 10,indent: 10),
        ListTile(
          leading: Icon(Icons.edit, color: Colors.blueAccent,),
          title: Text('Manage Products',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 15),),
          onTap: (){
            Navigator.of(context).pushNamed(userproductsscreen.routeNamed);
          },
        ),
        

      ]),
    );
  }
}