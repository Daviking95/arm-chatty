
class RegistrationRequest {
  final String email;
  final String password;

  RegistrationRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
