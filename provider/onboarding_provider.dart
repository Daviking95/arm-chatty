import 'package:all_flutter_gives/arm_test_code/extensions.dart';
import 'package:all_flutter_gives/arm_test_code/model/registration_request_model.dart';
import 'package:all_flutter_gives/arm_test_code/provider/base_view_model.dart';
import 'package:all_flutter_gives/arm_test_code/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/error_response_model.dart';
import '../model/generic_response_model.dart';
import '../network_constants.dart';
import '../screens/chat_list_screen.dart';
import '../screens/login_screen.dart';
import '../service/get_device_token.dart';
import '../service/onboarding_service.dart';
import 'package:dartz/dartz.dart' as dartz;

import '../widgets/snack_toasts.dart';

class OnboardingProvider extends BaseViewModel {

  bool _isLoading = false;


  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void loadApp(BuildContext context) async {
    Future.delayed(const Duration(seconds: 2), () async {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          print('User is currently signed out!');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (_) => false,
          );
        } else {
          print('User is signed in! ${user}');

          AppConstant.userCredential = user;

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ChatListScreen()),
            (_) => false,
          );
        }
      });
    });
  }

  void registerUser(
      BuildContext context, RegistrationRequest registrationRequest) async {
    await changeLoaderStatus(true, "Creating account");
    isLoading = true;
    notifyListeners();

    final dartz.Either<ErrorResponseModel, GenericResponseModel> responseData =
        await OnboardingRepo.instance.registerUser(registrationRequest);

    "responseDataLogin $responseData".logger();

    return responseData.fold((errorResponse) async {
      showSnackAtTheTop(message: errorResponse.message);

      await changeLoaderStatus(false, "");
      isLoading = false;
      notifyListeners();

      return;
    }, (successResponse) async {
      showSnackAtTheTop(message: successResponse.message, isSuccess: true);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));

      await changeLoaderStatus(false, "");
      isLoading = false;
      notifyListeners();
    });
  }

  void loginUser(BuildContext context, RegistrationRequest registrationRequest) async{
    await changeLoaderStatus(true, "Validating account");
    isLoading = true;
    notifyListeners();

    var token = await getDeviceToken();

    "loginUserToken $token".logger();

    final dartz.Either<ErrorResponseModel, UserCredential> responseData =
    await OnboardingRepo.instance.loginUser(registrationRequest);

    "responseDataLogin $responseData".logger();

    return responseData.fold((errorResponse) async {
      showSnackAtTheTop(message: errorResponse.message);

      await changeLoaderStatus(false, "");
      isLoading = false;
      notifyListeners();

      return;
    }, (successResponse) async {
      showSnackAtTheTop(message: "Login Successful", isSuccess: true);

      AppConstant.userCredential = successResponse.user;

      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => ChatListScreen()),
            (_) => false,

      );

      await changeLoaderStatus(false, "");
      isLoading = false;
      notifyListeners();
    });
  }

  void signOut(BuildContext context) async{
    await FirebaseAuth.instance.signOut();

    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => LoginScreen()),
          (_) => false,

    );
  }
}
