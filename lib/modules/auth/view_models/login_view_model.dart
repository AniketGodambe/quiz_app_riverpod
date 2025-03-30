import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app_riverpod/core/api/dio_client.dart';
import '../model/login_request.dart';
import '../model/user_details.dart';
import '../repository/auth_repo_impl.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final AuthRepoImpl _authRepository;

  LoginViewModel(this._authRepository) : super(LoginState.initial());

  Future<void> login(String mobileOrEmail, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    final request = LoginRequest(
      mobileOrEmail: mobileOrEmail,
      password: password,
    );

    final result = await _authRepository.login(request: request);

    result.fold((l) async {
      state = state.copyWith(
        isLoading: false,
        userDetails: l,
        isSuccess: true,
      );
    }, (r) {
      print(r);
      state = state.copyWith(
        isLoading: false,
        error: r.toString(),
      );
    });
  }
}

class LoginState {
  final bool isLoading;
  final String? error;
  final UserDetailsModel? userDetails;
  final bool isSuccess;

  LoginState({
    required this.isLoading,
    this.error,
    this.userDetails,
    required this.isSuccess,
  });

  factory LoginState.initial() => LoginState(
        isLoading: false,
        isSuccess: false,
      );

  LoginState copyWith({
    bool? isLoading,
    String? error,
    UserDetailsModel? userDetails,
    bool? isSuccess,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      userDetails: userDetails ?? this.userDetails,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

final loginViewModelProvider =
    StateNotifierProvider<LoginViewModel, LoginState>((ref) {
  final dio = DioClient();
  dio.init();
  final authRepository = AuthRepoImpl(dio);
  return LoginViewModel(authRepository);
});
