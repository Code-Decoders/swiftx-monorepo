import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class TransactionDetailView extends StatelessWidget {
  final int id;
  const TransactionDetailView({super.key, required this.id});
// Sample data for the transaction details
  final String transactionAmount = '\$150.00';
  final String transactionDate = 'September 10, 2024';
  final String transactionStatus = 'Completed';
  final String paymentMethod = 'Credit Card •••• 1234';
  final String transactionID = 'TXN1234567890';
  final String summary = 'Payment for services rendered on September 2024.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
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
                transactionAmount,
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                transactionStatus,
                style: TextStyle(
                  fontSize: 16,
                  color: transactionStatus == 'Completed'
                      ? Colors.green
                      : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            // Transaction Details
            buildDetailRow('Date', transactionDate),
            // buildDetailRowWithIcon(
            //     context, 'Payment Method', paymentMethod, Icons.credit_card),
            buildDetailRow('Transaction ID', transactionID),
            SizedBox(height: 20),
            // Summary
            Text(
              'Summary',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              summary,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            Spacer(),
            // Back to Home Button
            AppButton.primary(
              title: 'Back to Home',
              onTap: () {
                context.router.maybePop();
              },
            ),
            SizedBox(height: 20),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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
              SizedBox(width: 8),
              Text(
                detail,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
