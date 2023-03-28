
import 'package:flutter/material.dart';
import '/filters_screen.dart';


class drawer extends StatelessWidget {
  Widget listtile(String Title, IconData icon , VoidCallback Tap ) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        Title,
        style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold),
      ),
      onTap: Tap,
    );
  }
  //const drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          color: Theme.of(context).accentColor,
          height: 120,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: Text(
            'Cooking up!!',
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 29,
                color: Theme.of(context).primaryColor),
          ),
        ),
        listtile('Meals', Icons.restaurant, (){
          Navigator.of(context).pushReplacementNamed('/');
        }
        ),
        listtile('Filters', Icons.filter_list,(){
          Navigator.of(context).pushReplacementNamed(filters.routenamed);
        }
    )
    ]
    ),
    );
  }
}
