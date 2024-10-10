import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class RequestView extends StatelessWidget {
  const RequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Notifications'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: 10,
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Text('U$index'),
            ),
            title: Text('Mehedi Hasan'),
            subtitle: Text('Requested \$100'),
            trailing: SizedBox(
                width: 120,
                child: AppButton.primary(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    title: 'Pay Now',
                    onTap: () {
                      context.router.push(RequestDetailRoute(requestId: '1'));
                    })),
          );
        },
      ),
    );
  }
}
