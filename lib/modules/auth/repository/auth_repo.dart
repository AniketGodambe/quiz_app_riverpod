import 'package:dartz/dartz.dart';
import 'package:quiz_app_riverpod/modules/auth/model/signup_request.dart';

import '../model/login_request.dart';
import '../model/user_details.dart';

abstract class AuthRepo {
  Future<Either<UserDetailsModel, String>> login(
      {required LoginRequest request});

  Future<Either<UserDetailsModel, String>> signUp(
      {required SignUpRequest request});
}
