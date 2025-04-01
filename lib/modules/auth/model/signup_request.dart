class SignUpRequest {
  String? name;
  String? dob;
  String? mobile;
  String? email;
  String? password;

  SignUpRequest({
    this.name,
    this.dob,
    this.mobile,
    this.email,
    this.password,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
        name: json['name'] as String?,
        dob: json['dob'] as String?,
        mobile: json['mobile'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'dob': dob,
        'mobile': mobile,
        'email': email,
        'password': password,
      };
}
