import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/view/login/login_viewmodel.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  LoginView({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginViewModel(),
        builder: (context, _) {
          final model = context.watch<LoginViewModel>();
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: Form(
                key: formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Text(
                      'Welcome Back!',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Log in to your account',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 30),
                    // Email TextField
                    TextFormField(
                      onChanged: model.setEmail,
                      validator: model.validateEmail,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password TextField
                    TextFormField(
                      validator: model.validatePassword,
                      onChanged: model.setPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Align(
                    //   alignment: Alignment.centerRight,
                    //   child: TextButton(
                    //     onPressed: () {
                    //       // Handle forgot password action
                    //     },
                    //     child: Text('Forgot Password?'),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    AppButton.primary(
                      title: 'Log In',
                      onTap: () async {
                        if (!formKey.currentState!.validate()) return;
                        try {
                          await model.login();
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(e.toString()),
                          ));
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    // Sign Up Link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don’t have an account?'),
                          TextButton(
                            onPressed: () {
                              context.router.push(SignUpRoute());
                            },
                            child: Text('Sign Up',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
