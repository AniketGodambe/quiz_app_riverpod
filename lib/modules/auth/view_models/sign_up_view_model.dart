import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app_riverpod/core/api/dio_client.dart';
import 'package:quiz_app_riverpod/modules/auth/model/signup_request.dart';
import '../model/user_details.dart';
import '../repository/auth_repo_impl.dart';

final nameProvider = StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
final dobProvider = StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
final emailProvider = StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

final mobileProvider = StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});
final passwordProvider =
    StateProvider.autoDispose<TextEditingController>((ref) {
  return TextEditingController();
});

final signUpViewModelProvider =
    StateNotifierProvider<SignUpViewModel, SignUpState>((ref) {
  final dio = DioClient();
  dio.init();
  final authRepository = AuthRepoImpl(dio);
  return SignUpViewModel(authRepository);
});

class SignUpViewModel extends StateNotifier<SignUpState> {
  final AuthRepoImpl _authRepository;

  SignUpViewModel(this._authRepository) : super(SignUpState.initial());

  Future<void> signUp(
    String email,
    String name,
    String mobile,
    String password,
    String dob,
  ) async {
    state = state.copyWith(isLoading: true, error: null);

    final request = SignUpRequest(
      name: name,
      password: password,
      mobile: mobile,
      email: email,
      dob: "2000-01-01",
    );

    final result = await _authRepository.signUp(request: request);

    result.fold((l) async {
      state = state.copyWith(
        isLoading: false,
        userDetails: l,
        isSuccess: true,
      );
      state = SignUpState.initial();
    }, (r) {
      print(r);
      state = state.copyWith(
        isLoading: false,
        error: r.toString(),
      );
      state = SignUpState.initial();
    });
  }
}

class SignUpState {
  final bool isLoading;
  final String? error;
  final UserDetailsModel? userDetails;
  final bool isSuccess;

  SignUpState({
    required this.isLoading,
    this.error,
    this.userDetails,
    required this.isSuccess,
  });

  factory SignUpState.initial() => SignUpState(
        isLoading: false,
        isSuccess: false,
      );

  SignUpState copyWith({
    bool? isLoading,
    String? error,
    UserDetailsModel? userDetails,
    bool? isSuccess,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      userDetails: userDetails ?? this.userDetails,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
