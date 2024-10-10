import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/widget/button/app_button.dart';
import 'package:swiftx_app/widget/card/credit_card.dart';
import 'package:swiftx_app/widget/card/transaction_card.dart';
import 'package:swiftx_app/widget/icons/icon.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
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
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: AppButton.primary(
                  icon: AppIcons.money_send,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  title: "Send",
                  onTap: () {
                    context.router.push(ChooseRoute(isIncome: false));
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppButton.secondary(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  icon: AppIcons.money_receive,
                  title: "Request",
                  onTap: () {
                    context.router.push(ChooseRoute(isIncome: true));
                  },
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
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
      ),
    );
  }
}
