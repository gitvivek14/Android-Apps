import 'package:flutter/material.dart';
import './models/events.dart';

class eventslist extends StatelessWidget {
  final List<events> event;
  final Function delev;
  eventslist(this.event, this.delev);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        height: 550,
        child: event.isEmpty
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    color: Colors.black,
                    elevation: 5,
                    margin: EdgeInsets.all(10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text('Add Events!!!',textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.amber,
                              fontSize: 20,
                              fontStyle: FontStyle.italic,)),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    height: 400,
                    child: Image.network(
                      'https://img.freepik.com/free-vector/boy-wearing-shirt-with-macau-flag_1308-20549.jpg?w=360&t=st=1673996408~exp=1673997008~hmac=bb85323a8de9051f178141e918f12f978c74debb78651e23ce195103152e71f9',
                    repeat: ImageRepeat.noRepeat),
                  ),
                ],
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 6,
                    child: ListTile(
                      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(5)),
                      tileColor: Colors.black,
                      hoverColor: Colors.blueGrey,
                      style: ListTileStyle.drawer,
                      leading: CircleAvatar(
                          child: Text(
                            (index + 1).toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: Colors.amber),
                      title: Text(
                        event[index].event,
                        style: TextStyle(color: Colors.amber),
                      ),
                      subtitle: Text(
                        event[index].desc,
                        style: TextStyle(color: Colors.amber),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => delev(event[index].id),
                      ),
                    ),
                  );
                },
                itemCount: event.length,
              )
              );
              
  }
}
