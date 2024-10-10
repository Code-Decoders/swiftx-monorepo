import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swiftx_app/core/app_router.dart';
import 'package:swiftx_app/widget/button/app_button.dart';

@RoutePage()
class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Placeholder for Illustration
            Expanded(
              // Adjust height based on your illustration
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 400,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Create your SwiftX account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'SwiftX is a powerful tool that allows you to easily send, receive, and track all your transactions.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 30),
            // Sign Up Button
            AppButton.primary(
                title: 'Sign up',
                onTap: () {
                  context.router.push(SignUpRoute());
                }),
            SizedBox(height: 10),
            // Log In Button
            AppButton.secondary(
                title: 'Log in',
                onTap: () {
                  context.router.push(LoginRoute());
                }),
            SizedBox(height: 20),
            // Terms and Privacy Policy
            Text.rich(
              TextSpan(
                text: 'By continuing you accept our ',
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle Terms of Service tap
                      },
                  ),
                  TextSpan(
                    text: ' and ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Handle Privacy Policy tap
                      },
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
