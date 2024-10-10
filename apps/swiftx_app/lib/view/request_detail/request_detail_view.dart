import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class RequestDetailView extends StatelessWidget {
  final String requestId;
  const RequestDetailView({super.key, required this.requestId});

  final String requesterName = 'John Doe';
  final String requesterEmail = 'john.doe@example.com';
  final String requestAmount = '\$150.00';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Details'),
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40),
            // Requester Information
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://via.placeholder.com/150'), // Replace with actual profile image URL
            ),
            SizedBox(height: 20),
            Text(
              requesterName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              requesterEmail,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 40),
            // Request Amount
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    'Amount Requested',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    requestAmount,
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
            Spacer(),
            // Pay Button
            AppButton.primary(
              title: 'Pay Now',
              onTap: () {
                // Handle payment action
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Payment of $requestAmount sent!'),
                  ),
                );
              },
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
