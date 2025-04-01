import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:quiz_app_riverpod/core/api/api_urls.dart';
import 'package:quiz_app_riverpod/modules/auth/model/signup_request.dart';
import 'package:quiz_app_riverpod/modules/auth/repository/auth_repo.dart';

import '../../../core/api/dio_client.dart';
import '../../../core/network/network_check_service.dart';
import '../model/login_request.dart';
import '../model/user_details.dart';

class AuthRepoImpl extends AuthRepo with NetworkCheckService {
  final DioClient _dioClient;

  AuthRepoImpl(this._dioClient);

  @override
  Future<Either<UserDetailsModel, String>> login(
      {required LoginRequest request}) async {
    bool data = await checkInternet();

    if (!data) {
      return const Right('No Network found');
    } else {
      try {
        var result = await _dioClient.request(
          ApiUrls.login,
          Method.post,
          params: request.toJson(),
        );
        return result.fold((l) {
          if (l.data['success'] == true) {
            return Left(UserDetailsModel.fromJson(l.data));
          } else {
            return Right(l.data['message']);
          }
        }, (r) => Right(r.toString()));
      } catch (e) {
        return Right(e.toString());
      }
    }
  }

  @override
  Future<Either<UserDetailsModel, String>> signUp(
      {required SignUpRequest request}) async {
    bool data = await checkInternet();

    if (!data) {
      return const Right('No Network found');
    } else {
      try {
        log("DATAA ::=> ${jsonEncode(request.toJson())}");
        log("DATAA ::=> ${ApiUrls.baseURL + ApiUrls.signup}");

        var result = await _dioClient.request(
          ApiUrls.signup,
          Method.post,
          params: request.toJson(),
        );
        return result.fold((l) {
          log("DATAA ::=> ${l.data}");
          if (l.data['success'] == true) {
            return Left(UserDetailsModel.fromJson(l.data));
          } else {
            return Right(l.data['message']);
          }
        }, (r) => Right(r.toString()));
      } catch (e) {
        return Right(e.toString());
      }
    }
  }
}
