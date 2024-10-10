import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/view/account/account_viewmodel.dart';

@RoutePage()
class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => AccountViewModel(),
        builder: (context, _) {
          final model = context.watch<AccountViewModel>();
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text('Account', style: TextStyle(color: Colors.black)),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Profile Information
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                              'https://via.placeholder.com/150'), // Replace with actual image URL
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Mehedi Hasan',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'helloyouthmind@gmail.com',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '+8801995867406',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Menu Options
                  Expanded(
                    child: ListView(
                      children: [
                        ListTile(
                          leading: Icon(Icons.person, color: Colors.grey[700]),
                          title: Text('Personal Info'),
                          trailing: Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.grey[700]),
                          onTap: () {},
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.receipt_long, color: Colors.grey[700]),
                          title: Text('Transactions'),
                          trailing: Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.grey[700]),
                          onTap: () {
                            model.navigateToTransactions();
                          },
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.privacy_tip, color: Colors.grey[700]),
                          title: Text('Privacy Policy'),
                          trailing: Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.grey[700]),
                          onTap: () {},
                        ),
                        ListTile(
                          leading:
                              Icon(Icons.settings, color: Colors.grey[700]),
                          title: Text('Settings'),
                          trailing: Icon(Icons.arrow_forward_ios,
                              size: 16, color: Colors.grey[700]),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: Icon(Icons.logout, color: Colors.red),
                          title: Text('Logout',
                              style: TextStyle(color: Colors.red)),
                          onTap: () {
                            model.logout();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
