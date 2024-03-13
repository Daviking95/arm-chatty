import 'package:all_flutter_gives/arm_test_code/provider/onboarding_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/registration_request_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final onboardingProvider = context.watch<OnboardingProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('ARM Chatty - Signup'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // TextField(
            //   controller: _firstNameController,
            //   decoration: InputDecoration(
            //     labelText: 'First Name',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // SizedBox(height: 10),
            // TextField(
            //   controller: _lastNameController,
            //   decoration: InputDecoration(
            //     labelText: 'Last Name',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // SizedBox(height: 10),
            // TextField(
            //   controller: _phoneNumberController,
            //   decoration: InputDecoration(
            //     labelText: 'Phone Number',
            //     border: OutlineInputBorder(),
            //   ),
            // ),
            // SizedBox(height: 10),
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
                String firstName = _firstNameController.text;
                String lastName = _lastNameController.text;
                String phoneNumber = _phoneNumberController.text;
                String email = _emailController.text;
                String password = _passwordController.text;

                RegistrationRequest registrationRequest = RegistrationRequest(
                    // firstName: firstName,
                    // lastName: lastName,
                    email: email,
                    // phoneNumber: phoneNumber,
                    password: password);

                onboardingProvider.registerUser(context, registrationRequest);
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
                    'Register',
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
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              child: Text('Login to exiting account'),
            ),
          ],
        ),
      ),
    );
  }
}
