class LoginRequest {
  final String mobileOrEmail;
  final String password;

  LoginRequest({
    required this.mobileOrEmail,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'mobile_or_email': mobileOrEmail,
        'password': password,
      };
}
