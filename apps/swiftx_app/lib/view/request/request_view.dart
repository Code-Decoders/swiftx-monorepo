import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/application_viewmodel.dart';
import 'package:swiftx_app/view/request/request_viewmodel.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class RequestView extends StatelessWidget {
  const RequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RequestViewModel(),
        builder: (context, _) {
          final model = context.watch<RequestViewModel>();
          final user = context.watch<ApplicationViewModel>().user;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Request Notifications'),
              centerTitle: true,
            ),
            body: model.busy
                ? const Center(child: CircularProgressIndicator())
                : model.requests.isEmpty
                    ? const Center(child: Text('No requests found'))
                    : ListView.separated(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: model.requests.length,
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          final transaction = model.requests[index];
                          final value = user.id == transaction.approver_id
                              ? transaction.requester
                              : transaction.approver;
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(value.name[0]),
                            ),
                            title: Text(value.name),
                            subtitle: Text('Requested ${transaction.amount}'),
                            trailing: transaction.approver_id == user.id
                                ? SizedBox(
                                    width: 120,
                                    child: AppButton.primary(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        title: 'Pay Now',
                                        onTap: () {
                                          context.router.push(
                                              RequestDetailRoute(
                                                  request: transaction));
                                        }))
                                : SizedBox(
                                    width: 120,
                                    child: AppButton.secondary(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        title: 'Sended'),
                                  ),
                          );
                        },
                      ),
          );
        });
  }
}
