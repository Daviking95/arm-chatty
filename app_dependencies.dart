import 'package:all_flutter_gives/arm_test_code/provider/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDependencies extends StatelessWidget {
  final Widget child;

  const AppDependencies({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingProvider()),
      ],
      child: child,
    );
  }
}
