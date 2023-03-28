import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './models/events.dart';
import './eventslist.dart';
import './addevent.dart';

void main() => runApp(EventScheduler());

class EventScheduler extends StatelessWidget {
  const EventScheduler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eventscheduler',
      home: Home(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.black),
          backgroundColor: Colors.blueGrey[600]),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<events> eventsnew = [
    // events(event: 'events', desc: 'flutter worksho', date: DateTime.now(), id: (DateTime.now()).toString()),
    // events(event: 'event2', desc: 'basics of flutter', date: DateTime.now(), id: DateTime.now().toString()),
    // events(event: 'event', desc: 'basics of flutter', date: DateTime.now(), id: DateTime.now().toString()),
  ];

  void addeve(String e, String desc) {
    final newev = events(
      event: e,
      desc: desc,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      eventsnew.add(newev);
    });
  }
  void startaddnew(BuildContext ctx) {
      showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return addevnt(addeve);
        },
      );
    }

void delevent(String id){
  setState(() {
    eventsnew.removeWhere((element) => element.id==id);
  });

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Event Scheduler',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add,color: Colors.amber,),
            onPressed: () => startaddnew(context),
          ),
        ],
      ),
      body:  
      
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Card(
            child: Column(
          children: [
            eventslist(eventsnew,delevent),
          ],
        )),
      ]),
      floatingActionButton: FloatingActionButton(
          onPressed: () => startaddnew(context), child: Icon(Icons.add,color: Colors.amber),backgroundColor: Colors.black),
    );
  }
}
