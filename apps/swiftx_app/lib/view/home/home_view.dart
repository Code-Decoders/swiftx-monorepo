import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/widget/button/operational_button.dart';
import 'package:swiftx_app/widget/card/credit_card.dart';
import 'package:swiftx_app/widget/icons/icon.dart';
import 'package:swiftx_app/widget/icons/icons.dart';

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
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          children: [
            const SizedBox(height: 20),
            Text("Hi, Kunal",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            CreditCard(
              cardHolder: "Kunal",
              cardNumber: "1234 5678 9012 3456",
              balance: "AED 1000",
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  OperationalButton(
                    icon: AppIcons.money_send,
                    title: "Send",
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(),
                  ),
                  OperationalButton(
                    icon: AppIcons.money_receive,
                    title: "Receive",
                    onTap: () {},
                    color: const Color(0xffF9A825),
                  ),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(),
                  ),
                  OperationalButton(
                    icon: AppIcons.book_saved,
                    title: "Transactions",
                    onTap: () {},
                    color: const Color(0xffF9A825),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
