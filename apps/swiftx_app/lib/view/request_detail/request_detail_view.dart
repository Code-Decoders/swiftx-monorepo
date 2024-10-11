import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/core/app_utils.dart';
import 'package:swiftx_app/core/application_viewmodel.dart';
import 'package:swiftx_app/core/model/request_model.dart';
import 'package:swiftx_app/view/request_detail/request_detail_viewmodel.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class RequestDetailView extends StatelessWidget {
  final RequestModel request;
  const RequestDetailView({super.key, required this.request});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RequestDetailViewModel(),
        builder: (context, _) {
          final model = context.watch<RequestDetailViewModel>();
          final user = context.watch<ApplicationViewModel>().user;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Request Details'),
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
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // Requester Information
                  CircleAvatar(
                    radius: 50,
                    child: Text(request.requester.name[0]),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    request.requester.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    request.requester.email,
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 40),
                  // Request Amount
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Amount Requested',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${user.country == "UAE" ? "AED" : "SGD"} ${request.amount.toCurrency(countryCode: user.country)}",
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Pay Button
                  AppButton.primary(
                    title: 'Pay Now',
                    onTap: () {
                      try {
                        model.onPayRequest(request);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  AppButton.secondary(
                    title: "Decline",
                    onTap: () {
                      try {
                        model.onCancelRequest(request);
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          );
        });
  }
}
