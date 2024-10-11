import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/core/app_utils.dart';
import 'package:swiftx_app/core/application_viewmodel.dart';
import 'package:swiftx_app/core/model/transaction_model.dart';
import 'package:swiftx_app/widget/button/app_button.dart';
import 'package:intl/intl.dart';

@RoutePage()
class TransactionDetailView extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionDetailView({super.key, required this.transaction});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<ApplicationViewModel>().user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Transaction Amount
            Center(
              child: Text(
                "${user.country == "UAE" ? "AED" : "SGD"} ${transaction.amount.toCurrency(countryCode: user.country)}",
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Completed",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Transaction Details
            buildDetailRow(
                'Date',
                DateFormat("MMMM dd, yyyy H:mm:ss")
                    .format(transaction.created_at)),
            // buildDetailRowWithIcon(
            //     context, 'Payment Method', paymentMethod, Icons.credit_card),
            buildDetailRow('Transaction ID',
                "TXN${transaction.id.toString().padLeft(10, "0")}"),
            buildDetailRow(
                user.id == transaction.sender_id ? "Receiver Name" : "Sender Name",
                user.id == transaction.sender_id
                    ? transaction.receiver.name
                    : transaction.sender.name),
            buildDetailRow(
                user.id == transaction.sender_id ? "Receiver Email" : "Sender Email",
                user.id == transaction.sender_id
                    ? transaction.receiver.email
                    : transaction.sender.email),
            const Spacer(),
            // Back to Home Button
            AppButton.primary(
              title: 'Back to Home',
              onTap: () {
                context.router.maybePop();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper function to build detail rows without icon
  Widget buildDetailRow(String title, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          Text(
            detail,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  // Helper function to build detail rows with an icon for payment method
  Widget buildDetailRowWithIcon(
      BuildContext context, String title, String detail, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          Row(
            children: [
              Icon(icon, color: Theme.of(context).primaryColor, size: 20),
              const SizedBox(width: 8),
              Text(
                detail,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
