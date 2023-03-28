import 'package:flutter/material.dart';
import './Models/meals.dart';
import 'meal_detail_screen.dart';
import 'meal_item.dart';
class Favourite extends StatelessWidget {
  
  final List<Meal> favourite;
  Favourite(this.favourite);

  //const Favourite({super.key});

  @override
  Widget build(BuildContext context) {

    if(favourite.isEmpty){
      return Container(child: Center(child: Text('No Favourites yet'),));
    }else{return
      ListView.builder(
        itemBuilder: (ctx, index) {
          return mealitem(
            id: favourite[index].id,
            title: favourite[index].title,
            imageUrl: favourite[index].imageUrl,
            affordability: favourite[index].affordability,
            complexity: favourite[index].complexity,
            duration: favourite[index].duration,
          );
        },
        itemCount: favourite.length,
      );

    }
    
  }
}