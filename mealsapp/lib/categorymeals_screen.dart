import 'package:flutter/material.dart';
import '/meal_item.dart';
import '003 dummy-data.dart';
import './Models/meals.dart';

class Categorymeals_screen extends StatefulWidget {
  static const routenamed = '/categorie_meals';
  final List<Meal> avaialblemeals;
  Categorymeals_screen(this.avaialblemeals);

  @override
  State<Categorymeals_screen> createState() => _Categorymeals_screenState();
}

class _Categorymeals_screenState extends State<Categorymeals_screen> {
  //const Categorymeals({super.key});
  @override
  Widget build(BuildContext context) {
    final routeargs =
        ModalRoute.of(context)?.settings.arguments as Map<String,String>;
    final categorytitle = routeargs['title'];
    final categoryid = routeargs['id'];

    //var widget;
    final filteredmeals = widget.avaialblemeals.where((item) {
      return item.categories.contains(categoryid);
    }).toList();
    return Scaffold(
      appBar: AppBar(title: Text(categorytitle as String)),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return mealitem(
            id: filteredmeals[index].id,
            title: filteredmeals[index].title,
            imageUrl: filteredmeals[index].imageUrl,
            affordability: filteredmeals[index].affordability,
            complexity: filteredmeals[index].complexity,
            duration: filteredmeals[index].duration,
          );
        },
        itemCount: filteredmeals.length,
      ),
    );
  }
}
