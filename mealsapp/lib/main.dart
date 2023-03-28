import 'package:flutter/material.dart';
import '/003%20dummy-data.dart';
import '/Models/meals.dart';
import '/categorymeals_screen.dart';
import '/filters_screen.dart';
import '/meal_detail_screen.dart';
import '/tabscreen.dart';
import 'categories_screen.dart';
import 'filters_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final List<Meal> favorite =[];

  Map<String,bool> filterset ={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };
  bool ismealfav(String id){
    return favorite.any((meal) => meal.id==id);
  }

  void togglefav(String mealid){
    final existigindex = favorite.indexWhere((meal) => meal.id == mealid);
    if(existigindex>=0){
      setState(() {
        favorite.removeAt(existigindex);
      });
    }else{
      favorite.add(DUMMY_MEALS.firstWhere((meal) => meal.id==mealid));
    }
  }
  List<Meal> avaialble = DUMMY_MEALS;

  void setfilters(Map<String,bool> filters){
    filterset=filters;
    setState(() {
      avaialble = DUMMY_MEALS.where((meal){
        if(filterset['gluten']&& !meal.isGlutenFree){
          return false;
        }
        if(filterset['lactose']&& !meal.isLactoseFree){
          return false;
        }
        if(filterset['vegan']&& !meal.isVegan){
          return false;
        }
        if(filterset['vegetarian']&& !meal.isVegetarian){
          return false;
        }
        return true;
        //

      }).toList();
    });
  }
  //const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meals App',
      initialRoute: '/',
      
      routes: {'/':(ctx) => TabsScreen(favorite),
        Categorymeals_screen.routenamed:(ctx) => Categorymeals_screen(avaialble),
        mealdetailscreen.routenamed:(ctx) => mealdetailscreen(togglefav,ismealfav),
        filters.routenamed:(ctx) => filters(filterset,setfilters), 
      },
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(
            color: Color.fromRGBO(20, 51, 51, 1),
          ),
          bodyText2:   TextStyle(color: Color.fromRGBO(20, 51, 51, 1)
          ),
          headline6:  TextStyle(fontSize: 20,fontFamily: 'RobotoCondensed',fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  //const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('Meals App')),
      body: Text('Body'),
    );
  }
}
