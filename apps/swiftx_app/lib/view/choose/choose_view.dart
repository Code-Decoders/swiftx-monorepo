import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/view/choose/choose_viewmodel.dart';

@RoutePage()
class ChooseView extends StatelessWidget {
  final bool isIncome;
  const ChooseView({super.key, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ChooseViewModel(),
        builder: (context, _) {
          final model = context.watch<ChooseViewModel>();
          return Scaffold(
            appBar: AppBar(
              title: const Text("Choose Recipient"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please select your recipient to send money.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    onChanged: model.setQuery,
                    decoration: InputDecoration(
                      hintText: 'Search "Recipient Email"',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Most Recent',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  model.busy
                      ? const Center(child: CircularProgressIndicator())
                      : Expanded(
                          child: ListView.builder(
                            itemCount: model.recipients.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                onTap: () => {
                                  model.navigateToRecipient(
                                      model.recipients[index], isIncome)
                                },
                                leading: CircleAvatar(
                                  child: Text(model.recipients[index].name[0]),
                                ),
                                title: Text(model.recipients[index].name),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "@${model.recipients[index].username}"),
                                    Text(model.recipients[index].email),
                                  ],
                                ),
                                isThreeLine: true,
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}
