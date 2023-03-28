

import 'package:flutter/material.dart';
import '/categorymeals_screen.dart';

class category_item extends StatelessWidget {
  final String title;
  final Color color;
  final String id;
  category_item(this.title, this.color, this.id);

  void selectcategory(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(Categorymeals_screen.routenamed, arguments: {'id': id, 'title': title});
  }

  ///const category_item({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectcategory(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color, color.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.topRight),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
