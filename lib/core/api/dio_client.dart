import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:quiz_app_riverpod/core/network/network_check_service.dart';

import 'api_urls.dart';

enum Method { post, get, put, delete, patch }

class DioClient with NetworkCheckService {
  late Dio dio;

  //this is for header
  static header() => {
        'Content-Type': 'application/json',
      };

  init() {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseURL,
        headers: header(),
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    return this;
  }

  Future<Either<Response, Exception>> request(String url, Method method,
      {params}) async {
    Response response;

    try {
      if (method == Method.post) {
        response = await dio.post(url, data: params);
      } else if (method == Method.put) {
        response = await dio.put(url, data: params);
      } else if (method == Method.delete) {
        response = await dio.delete(url);
      } else if (method == Method.patch) {
        response = await dio.patch(url, queryParameters: params);
      } else {
        response = await dio.get(
          url,
          queryParameters: params,
        );
      }

      return Left(response);
    } on SocketException {
      throw Right(Exception("No Internet Connection"));
    } on FormatException {
      throw Right(Exception("Bad Response Format!"));
    } on DioException catch (e) {
      throw Right(Exception(e));
    } catch (e, s) {
      print("$e ::=> $s");
      throw Right(Exception("Something Went Wrong"));
    }
  }
}
