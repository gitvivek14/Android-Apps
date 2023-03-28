import 'package:flutter/material.dart';
import 'Models/meals.dart';
import 'meal_detail_screen.dart';

class mealitem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final Complexity complexity;
  final Affordability affordability;
  final int duration;

  mealitem(

      {this.title,
      this.id,
      this.affordability,
      this.complexity,
      this.duration,
      this.imageUrl});

  String get complextext{
    switch(complexity){
      case Complexity.Simple:
      return 'Simple';
      break;
      case Complexity.Challenging:
      return 'Challenging';
      break;
      case Complexity.Hard:
      return 'Hard';
      break;
    }

  }
  String get affordtext{
    switch(affordability){
      case Affordability.Affordable:
      return 'Affordable';
      break;
      case Affordability.Luxurious:
      return 'Luxurious';
      break;
      case Affordability.Pricey:
      return 'Pricey';
      break;
    }

  }
  void selectmeal(BuildContext ctx){
    Navigator.of(ctx).pushNamed(mealdetailscreen.routenamed,arguments: id,);
  }

  //const mealitem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectmeal(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(
                  imageUrl as String,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  width: 220,
                  color: Colors.black54,
                  padding: EdgeInsets.all(10),
                  child: Text(title as String, style: TextStyle(fontSize: 26,color: Colors.white,),
                  softWrap: true,
                  overflow: TextOverflow.fade,),
                ),
              )
            ],
          ),
          Padding(padding: EdgeInsets.all(10),
          child: Row
          
          (mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

            Row(children: [
              Icon(Icons.schedule,),
              SizedBox(width: 10,),
              Text('$duration min',)
            ],),
            Row(children: [
              Icon(Icons.work_history_sharp,),
              SizedBox(width: 10,),
              Text(complextext as String,)
            ],
            ),
            Row(children: [
              Icon(Icons.attach_money,),
              SizedBox(width: 10,),
              Text(affordtext as String,)
            ],
            )
          ])
          ,)
        ]),
      ),
    );
  }
}
