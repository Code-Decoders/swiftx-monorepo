import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/view/signup/signup_viewmodel.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SignUpViewModel(),
        builder: (context, _) {
          final model = context.watch<SignUpViewModel>();
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Sign up to get started!',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    onChanged: model.setUsername,
                    validator: model.validateUsername,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Name TextField
                  TextFormField(
                    onChanged: model.setName,
                    validator: model.validateName,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email TextField
                  TextFormField(
                    validator: model.validateEmail,
                    onChanged: model.setEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  InternationalPhoneNumberInput(
                    countries: const [
                      'AE',
                      'SG',
                    ],
                    validator: model.validatePhone,
                    onInputChanged: model.setPhone,
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.DIALOG,
                      countryComparator: (a, b) => a.name!.compareTo(b.name!),
                    ),
                    textFieldController: TextEditingController(),
                    formatInput: true,
                    inputDecoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Password TextField
                  TextFormField(
                    onChanged: model.setPassword,
                    validator: model.validatePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Sign Up Button
                  TextFormField(
                    validator: model.validateConfirmPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  AppButton.primary(
                    title: 'Sign Up',
                    onTap: () async {
                      if (!formKey.currentState!.validate()) return;
                      try {
                        await model.signUp();
                      } on Exception catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.toString()),
                        ));
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  // Login Link
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            context.router.push(LoginRoute());
                          },
                          child: Text('Log In',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor)),
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
