import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/view/kyc/kyc_viewmodel.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class KycView extends StatelessWidget {
  final String country;
  const KycView({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => KycViewModel(),
        builder: (context, _) {
          final model = context.watch<KycViewModel>();
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('KYC & AML Verification',
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 16),
                  Text(
                      'Country: ${country == "AE" ? "United Arab Emirates" : "Singapore"}',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 16),
                  AppButton.primary(
                      title: 'Start Verification',
                      onTap: () async {
                        try {
                          await model.submitKyc();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.toString()),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
          );
        });
  }
}
