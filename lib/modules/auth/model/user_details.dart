class UserDetailsModel {
  String? message;
  bool? success;
  UserDetails? data;

  UserDetailsModel({this.message, this.success, this.data});

  factory UserDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
      message: json['message'] as String?,
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : UserDetails.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'success': success,
        'data': data?.toJson(),
      };
}

class UserDetails {
  String? dob;
  String? email;
  String? mobile;
  String? name;
  int? userId;

  UserDetails({this.dob, this.email, this.mobile, this.name, this.userId});

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        dob: json['dob'] as String?,
        email: json['email'] as String?,
        mobile: json['mobile'] as String?,
        name: json['name'] as String?,
        userId: json['user_id'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'dob': dob,
        'email': email,
        'mobile': mobile,
        'name': name,
        'user_id': userId,
      };
}
