import 'package:dartz/dartz.dart';

import '../model/login_request.dart';
import '../model/user_details.dart';

abstract class AuthRepo {
  Future<Either<UserDetailsModel, String>> login(
      {required LoginRequest request});
}
