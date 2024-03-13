

import 'package:all_flutter_gives/arm_test_code/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/error_response_model.dart';
import '../model/generic_response_model.dart';
import '../model/registration_request_model.dart';

abstract class OnboardingService{
  Future<Either<ErrorResponseModel, GenericResponseModel>>
  registerUser(RegistrationRequest registrationRequest);

  Future<Either<ErrorResponseModel, UserCredential>>
  loginUser(RegistrationRequest registrationRequest);
}

class OnboardingRepo extends OnboardingService{

  OnboardingRepo._();

  static OnboardingRepo instance = OnboardingRepo._();

  @override
  Future<Either<ErrorResponseModel, GenericResponseModel>> registerUser(RegistrationRequest registrationRequest) async{
    // TODO: implement registerUser
    try {

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: registrationRequest.email,
        password: registrationRequest.password,
      );

      "userCredential $userCredential".logger();

      return Right(GenericResponseModel(message: "Registration successful", success: true, status: 201));
    } catch (e) {
      "registerUserError ${e}".logger();
      "registerUserError ${e.runtimeType}".logger();

      return Left(ErrorResponseModel.fromJson(e as Map<String, dynamic>));
    }
  }

  @override
  Future<Either<ErrorResponseModel, UserCredential>> loginUser(RegistrationRequest registrationRequest) async{
    // TODO: implement loginUser
    try {

      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: registrationRequest.email,
        password: registrationRequest.password,
      );

      "loginCredential ${userCredential}".logger();

      return Right(userCredential);
    } catch (e) {
      "loginUserError ${e}".logger();
      "loginUserError ${e.runtimeType}".logger();

      return Left(ErrorResponseModel(status: 400, success: false, message: e.toString()));
    }
  }


}