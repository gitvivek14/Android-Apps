

import 'package:flutter/material.dart';

class addevnt extends StatefulWidget {
  final Function addvent;
  addevnt(this.addvent);
  ///const addevnt({super.key});

  @override
  State<addevnt> createState() => _addevntState();
}

class _addevntState extends State<addevnt> {


  
  final eventcontrol = TextEditingController();
  final desccontrol = TextEditingController();

  void submitevent(){
    final evenstadded = eventcontrol.text;
    final descadded = desccontrol.text;
    if(evenstadded.isEmpty||descadded.isEmpty){
      return;
    }
    widget.addvent(evenstadded,descadded);
    Navigator.of(context).pop();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(labelText: 'Add Name of the Event'),
            controller: eventcontrol,
            onSubmitted: (_) {},
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            
            maxLength: 50,
            decoration: InputDecoration(labelText: 'Enter Description'),
            controller: desccontrol,
            ),
            
          
          ElevatedButton(
            onPressed: submitevent,
            child: Text('Add Event',style: TextStyle(color: Colors.amber),),
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black),
                backgroundColor: MaterialStateProperty.all(Colors.black)),
                
          ),
        ]),
      ),
    );
  }
}
