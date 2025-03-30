import 'dart:async';

import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

mixin NetworkCheckService {
  Future<bool> checkInternet() async {
    bool result = await InternetConnection().hasInternetAccess;
    return result;
  }
}
