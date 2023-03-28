import 'package:expenseapp/Models/transactions.dart';
import 'package:expenseapp/widgets/TransactionList.dart';
import 'package:expenseapp/widgets/charts.dart';
import 'package:expenseapp/widgets/new_transaction.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'myflutterapp',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Roboto',
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void deletetransaction(String id){
    setState(() {
      usertransaction.removeWhere((element) => element.id==id);
    });
   
  }
  List<Transactions> get _recenttxn {
    return usertransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
  bool _showchart = false;

  final List<Transactions> usertransaction = [
    // Transactions(id: '1', title: 'Shoes', amount: 100.0, date: DateTime.now()),
    // Transactions(id: '2', title: 'Cap', amount: 12, date: DateTime.now()),
  ];
  void _addnewtransaction(String Title, double Amount, DateTime dt) {
    final newtx = Transactions(
        id: DateTime.now().toString(),
        title: Title,
        amount: Amount,
        date: dt,
    );
    setState(() {
      usertransaction.add(newtx);
    });
  }

  void _startaddtransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: New_Transaction(_addnewtransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  // String? titleinput;
  @override
  Widget build(BuildContext context) {
    final islandsc= MediaQuery.of(context).orientation==Orientation.landscape;
    final appbar=AppBar(
        title: Text(
          'Expense App',
          style:
              TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: (() => _startaddtransaction(context)),
              icon: Icon(Icons.add))
        ],
      );
      final txwidget = Container(
              height: (MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
              
              child: TransactionList(usertransaction,deletetransaction));
    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

              if(islandsc)Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Show Chart'),
              Switch.adaptive(value: _showchart, onChanged: (val){
                setState(() {
                  _showchart=val;
                });
              })
            ],),
            if(!islandsc)Container
            (height: (MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
              child: Charts(_recenttxn)),
            if(!islandsc)txwidget,
            if(islandsc)_showchart?Container
            (height: (MediaQuery.of(context).size.height-appbar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
              child: Charts(_recenttxn))
            :txwidget
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (() => _startaddtransaction(context)),
        child: Icon(Icons.add),
      ),
    );
  }
}
