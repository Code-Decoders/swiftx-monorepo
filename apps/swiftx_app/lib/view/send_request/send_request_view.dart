import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class SendRequestView extends StatelessWidget {
  final bool isIncome;
  const SendRequestView({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("You Have", style: TextStyle(color: Colors.grey)),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.00',
                            hintStyle: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Text("AED",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text("1 AED = 0.35 SGD",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Divider(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.00',
                            hintStyle: TextStyle(
                                fontSize: 24,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Text("SGD",
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text("1 SGD = 2.85 AED",
                      style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            SizedBox(height: 20),
            AppButton.primary(
                title: isIncome ? "Request" : "Send", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
