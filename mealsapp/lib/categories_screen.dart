import 'package:flutter/material.dart';
import '/category_item.dart';
import '003 dummy-data.dart';

class categories extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return  
      GridView(
        padding: EdgeInsets.all(10),
        children: DUMMY_CATEGORIES
            .map((catdata) => category_item(catdata.title as String, catdata.color,catdata.id as String))
            .toList(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        )
        );

    
    
  }
}
