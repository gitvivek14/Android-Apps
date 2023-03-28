import 'package:expenseapp/Models/transactions.dart';
import 'package:expenseapp/widgets/chartbars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Charts extends StatelessWidget {
  final List<Transactions> recenttxn;
  Charts(this.recenttxn);

  List<Map<String, Object>> get groupedtransaction {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.00;
      for (var i = 0; i < recenttxn.length; i++) {
        if (recenttxn[i].date.day == weekday.day &&
            recenttxn[i].date.month == weekday.month &&
            recenttxn[i].date.year == weekday.year) {
          totalsum += recenttxn[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalsum
      };
    }).reversed.toList();
  }

  double get totalsepending {
    //for week
    return groupedtransaction.fold(0.00, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  // const Charts({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: groupedtransaction.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              
              child: ChartBar((e['day'] as String), (e['amount'] as double),
                  totalsepending==0?0.00:(e['amount'] as double) / totalsepending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
