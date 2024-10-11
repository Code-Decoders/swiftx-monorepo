import 'package:auto_route/auto_route.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/core/application_viewmodel.dart';
import 'package:swiftx_app/widget/icons/icon.dart';

@RoutePage(name: "AppRoute")
class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ApplicationViewModel(),
        builder: (context, _) {
          return AutoTabsRouter(
              routes: [
                HomeTab(),
                ExchangeTab(),
                TransactionTab(),
                ProfileTab(),
              ],
              builder: (context, child) {
                final tabsRouter = AutoTabsRouter.of(context);
                return Scaffold(
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  body: child,
                  bottomNavigationBar: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: BottomNavigationBar(
                        currentIndex: tabsRouter.activeIndex,
                        onTap: (index) => {tabsRouter.setActiveIndex(index)},
                        selectedItemColor: Theme.of(context).primaryColor,
                        unselectedItemColor: Colors.grey,
                        showSelectedLabels: false,
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.notifications_active),
                            label: 'Exchange',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.history),
                            label: 'Transactions',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person),
                            label: 'Profile',
                          ),
                        ]),
                  ),
                );
              });
        });
  }
}
