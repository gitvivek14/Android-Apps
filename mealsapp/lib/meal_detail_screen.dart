import 'package:flutter/material.dart';
import '003 dummy-data.dart';

class mealdetailscreen extends StatelessWidget {
  final Function togglefav;
  final Function ismealfav;
  mealdetailscreen(this.togglefav,this.ismealfav);
  //const mealdetailscreen({super.key});
  static const routenamed = '/meals-detail';

  Widget buildsectiontitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget buildcontainer(Widget child1, BuildContext context) {
    return (Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final mealid = ModalRoute.of(context)?.settings.arguments as String;
    final selectedmeal = DUMMY_MEALS.firstWhere(
      (element) => element.id == mealid,
    );
    return Scaffold(
      appBar: AppBar(title: Text('Description')),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 299,
            width: double.infinity,
            child: Image.network(
              selectedmeal.imageUrl as String,
              fit: BoxFit.cover,
            ),
          ),
          buildsectiontitle(context, 'Ingredients'),
          buildcontainer(
            ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(selectedmeal.ingredients[index])),
                );
              },
              itemCount: selectedmeal.ingredients.length,
            ),
            context,
          ),
          buildsectiontitle(context, 'Steps'),
          buildcontainer(
              ListView.builder(
                itemBuilder: (ctx, index) {
                  return Column(children: [
                    ListTile(
                      leading: CircleAvatar(
                          child: Text('#' + (index + 1).toString())),
                      title: Text(selectedmeal.steps[index]),
                    ),
                    Divider(),
                  ]);
                },
                itemCount: selectedmeal.steps.length,
              ),
              context)
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
            ismealfav(mealid) ? Icons.star : Icons.star_border),
        onPressed: () => togglefav(mealid),
      ),
    );
  }
}
