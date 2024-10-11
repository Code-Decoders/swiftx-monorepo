import 'package:flutter/material.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/model/transaction_model.dart';
import 'package:swiftx_app/widget/icons/icon.dart';
import 'package:auto_route/auto_route.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String description;
  final String amount;
  final bool isIncome;
  final String currency;
  final TransactionModel transaction;

  const TransactionCard({
    super.key,
    required this.title,
    required this.description,
    required this.amount,
    required this.isIncome,
    required this.currency, required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.router.push(TransactionDetailRoute(transaction: transaction));
      },
      leading: CircleAvatar(
        backgroundColor: isIncome ? Colors.green : Colors.orange,
        child: AppIcon(
          icon: isIncome ? AppIcons.money_receive : AppIcons.money_send,
          color: Colors.white,
        ),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Text(
        description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Text(
        isIncome ? '+ $currency $amount' : '- $currency $amount',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isIncome ? Colors.greenAccent : Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
