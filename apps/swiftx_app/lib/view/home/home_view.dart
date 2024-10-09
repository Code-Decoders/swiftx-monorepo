import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/widget/button/operational_button.dart';
import 'package:swiftx_app/widget/card/credit_card.dart';
import 'package:swiftx_app/widget/card/transaction_card.dart';
import 'package:swiftx_app/widget/icons/icon.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: const Color(0xffFAFAFA),
          leadingWidth: 40,
          leading: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: AppIcon(
              icon: AppIcons.menu,
              size: 20,
              color: Colors.black,
            ),
          ),
          title: Text('Home', style: Theme.of(context).textTheme.headlineSmall),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            const SizedBox(height: 20),
            Text("Hi, Kunal",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 20),
            const CreditCard(
              cardHolder: "Kunal",
              cardNumber: "1234 5678 9012 3456",
              balance: "AED 1000",
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OperationalButton(
                    icon: AppIcons.money_send,
                    title: "Send",
                    onTap: () {},
                    color: Colors.orange,
                  ),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  OperationalButton(
                    icon: AppIcons.money_receive,
                    title: "Receive",
                    onTap: () {},
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  ),
                  OperationalButton(
                    icon: AppIcons.book_saved,
                    title: "Transactions",
                    onTap: () {},
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            Text("Recent Transactions",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  return TransactionCard(
                    title: "Payment",
                    description: "Payment for the services",
                    amount: 100,
                    isIncome: false,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
