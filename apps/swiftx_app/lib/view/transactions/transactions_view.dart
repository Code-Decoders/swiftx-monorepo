import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/widget/card/transaction_card.dart';

@RoutePage()
class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Transactions', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        padding: EdgeInsets.symmetric(vertical: 20),
        itemBuilder: (context, index) {
          const random = [true, false];
          final isIncome = random[Random().nextInt(random.length)];
          return TransactionCard(
            title: "Payment",
            description: "Payment for the services",
            amount: 100,
            isIncome: isIncome,
          );
        },
      ),
    );
  }
}
