import 'package:flutter/material.dart';
import '../Models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  //const TransactionList({super.key});
  final List<Transactions> tansact;
  final Function deletetx;
  TransactionList(this.tansact, this.deletetx);
  @override
  Widget build(BuildContext context) {
    return tansact.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text('Add Transactions'),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'lib/Assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text(
                        '₹' + (tansact[index].amount).toString(),
                      )),
                    ),
                  ),
                  title: Text(tansact[index].title),
                  subtitle:
                      Text(DateFormat.yMMMd().format(tansact[index].date)),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                              icon: Icon(Icons.delete), label: Text('Delete'),onPressed: () => deletetx(tansact[index].id,))
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deletetx(tansact[index].id),
                        ),
                ),
              );
            },
            itemCount: tansact.length,
          );
  }
}
