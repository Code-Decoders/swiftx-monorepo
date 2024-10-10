import 'package:flutter/material.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/widget/icons/icon.dart';
import 'package:auto_route/auto_route.dart';

class TransactionCard extends StatelessWidget {
  final String title;
  final String description;
  final double amount;
  final bool isIncome;

  const TransactionCard({
    Key? key,
    required this.title,
    required this.description,
    required this.amount,
    required this.isIncome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        context.router.push(TransactionDetailRoute(id: 1));
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
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: Text(
        isIncome ? '+ AED $amount' : '- AED $amount',
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: isIncome ? Colors.greenAccent : Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
