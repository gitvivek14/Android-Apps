import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class New_Transaction extends StatefulWidget {
  final Function addtx;
  New_Transaction(this.addtx);

  @override
  State<New_Transaction> createState() => _New_TransactionState();
}

class _New_TransactionState extends State<New_Transaction> {
  //const New_Transaction({super.key});
  final titlecontroller = TextEditingController();

  final amountcontroller = TextEditingController();
  DateTime storedate = DateTime.now();

  void submitdata() {
    if(amountcontroller.text==null){
      return;
    }
    final enetrdata = titlecontroller.text;
    final amotdata = double.parse(amountcontroller.text);
    if (enetrdata.isEmpty || amotdata <= 0||storedate==null) {
      return;
    }
    widget.addtx(enetrdata, amotdata,storedate);
    Navigator.of(context).pop(); // remove topmost screen
  }

  void _datepicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        storedate = pickeddate;
      });
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(top: 10,right: 10,left: 10,bottom: MediaQuery.of(context).viewInsets.bottom+10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titlecontroller,
              onSubmitted: (value) => submitdata(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (value) => submitdata(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(
                    storedate == null
                      ? 'No Date Choosen!!'
                      : DateFormat.yMd().format(storedate),
                      ),
                  SizedBox(
                    width: 20,
                  ),
                  TextButton(onPressed: _datepicker, child: Text('Choose Date'))
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.purple)),
              onPressed: submitdata,
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
