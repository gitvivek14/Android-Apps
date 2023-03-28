import 'dart:ffi';

import 'package:flutter/material.dart';
import '/main_drawer.dart';
class filters extends StatefulWidget {

  static const routenamed = '/filters';
  final Function recfiltes;
  final Map<String,bool> currvalue;
  filters(this.currvalue,this.recfiltes);

  @override
  State<filters> createState() => _filtersState();
}

class _filtersState extends State<filters> {
  bool isVegan     = false;
  bool isVegetarian = false;
  bool isGlutenFree = false;
  bool isLactoseFree= false;

  @override
  void initState() {

    isVegan = widget.currvalue['vegan'];
    isLactoseFree = widget.currvalue['lactose'];
    isVegetarian = widget.currvalue['vegetarian'];
    isGlutenFree = widget.currvalue['gluten'];
    // TODO: implement initState
    super.initState();
  }

  Widget buildswitchtile(String title,String desc, bool curr, Function update){
    return SwitchListTile(value: curr, onChanged: update(),
            title:Text(title) ,subtitle: Text(desc) ,
            );
  }

  
  void setfn(bool val1, bool val2){
    setState(() {
      val1=val2;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Filters'),
      actions: [
        IconButton(onPressed: (){
          final selectefilters={
            'gluten':isGlutenFree,
    'lactose':isLactoseFree,
    'vegan':isVegan,
    'vegetarian':isVegetarian,
          };
          widget.recfiltes(selectefilters);
        }, icon: Icon(Icons.save),)
      ],),
      drawer: drawer(),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text('Adjust your Meals'),

        ),
        Expanded(child: ListView(
          children: [
            SwitchListTile(value: isGlutenFree as bool, onChanged: (newval){
              setState(() {
                isGlutenFree=newval;
              });
            },
            title:Text('Gluten Free Items') ,subtitle: Text('Select for only Gluten-Free Items') ,
            ),
            SwitchListTile(value: isVegan as bool, onChanged: (newval){
              setState(() {
                isVegan=newval;
              });
            },
            title:Text('Vegan Items') ,subtitle: Text('Select for only Vegan Items') ,
            ),
            SwitchListTile(value:isVegetarian as bool, onChanged: (newval){
              setState(() {
                isVegetarian=newval;
              });
            },
            title:Text('Vegetarian') ,subtitle: Text('Select for only vegetarain Items') ,
            ),
            SwitchListTile(value: isLactoseFree as bool, onChanged: (newval){
              setState(() {
                isLactoseFree=newval;
              });
            },
            title:Text('Lactose Free') ,subtitle: Text('Select for only Lactose-free Items') ,
            ),
          ],
          
        ),)
      ]),
    );
  }
}