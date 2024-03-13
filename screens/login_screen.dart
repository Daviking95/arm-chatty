import 'package:all_flutter_gives/arm_test_code/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/registration_request_model.dart';
import '../provider/onboarding_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final onboardingProvider = context.watch<OnboardingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('ARM Chatty - Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement registration logic here
                String email = _emailController.text;
                String password = _passwordController.text;

                RegistrationRequest registrationRequest = RegistrationRequest(
                    email: email,
                    password: password);

                onboardingProvider.loginUser(context, registrationRequest);
                // Once registered, navigate to next screen
                // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
              },
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Center(
                  child: onboardingProvider.isLoading ? CircularProgressIndicator(color: Colors.white,) : Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
              child: Text('Register new account'),
            ),
          ],
        ),
      ),
    );
  }
}
