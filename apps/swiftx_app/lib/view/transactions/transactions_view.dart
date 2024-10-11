import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/core/app_utils.dart';
import 'package:swiftx_app/view/transactions/transactions_viewmodel.dart';
import 'package:swiftx_app/widget/card/transaction_card.dart';

@RoutePage()
class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});

  @override
  State<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TransactionsViewModel(),
        builder: (context, _) {
          final model = context.watch<TransactionsViewModel>();
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title:
                  const Text('Transactions', style: TextStyle(color: Colors.black)),
              centerTitle: true,
            ),
            body: model.busy
                ? const Center(child: CircularProgressIndicator())
                : model.transactions.isEmpty
                    ? const Center(child: Text('No transactions found'))
                    : ListView.builder(
                        itemCount: model.transactions.length,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemBuilder: (context, index) {
                          final transaction = model.transactions[index];
                          final user = model.user.id == transaction.sender_id
                              ? transaction.receiver
                              : transaction.sender;

                          return TransactionCard(
                            transaction: transaction,
                            currency:
                                model.user.country == "UAE" ? "AED" : "SGD",
                            title: user.name,
                            description: user.email,
                            amount: transaction.amount
                                .toCurrency(countryCode: model.user.country),
                            isIncome: model.user.id == transaction.receiver_id,
                          );
                        },
                      ),
          );
        });
  }
}
