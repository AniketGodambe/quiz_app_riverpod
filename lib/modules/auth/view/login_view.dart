import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiz_app_riverpod/modules/auth/view_models/login_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  bool loginWithEmail = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final mobileOrEmail = loginWithEmail
        ? emailController.text.trim()
        : mobileController.text.trim();
    final password = passwordController.text.trim();

    if (mobileOrEmail.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    await ref
        .read(loginViewModelProvider.notifier)
        .login(mobileOrEmail, password);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);

    // Handle success state
    if (state.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Navigate to home screen or perform other actions
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        // Clear the form
        emailController.clear();
        mobileController.clear();
        passwordController.clear();
        // Reset the state
        ref.read(loginViewModelProvider.notifier).state = LoginState.initial();
      });
    }

    // Handle error state
    if (state.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.error!)),
        );
        // Clear the error
        ref.read(loginViewModelProvider.notifier).state =
            state.copyWith(error: null);
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                  loginWithEmail ? 'Login with Email' : 'Login with Mobile'),
              value: loginWithEmail,
              onChanged: (value) {
                setState(() {
                  loginWithEmail = value;
                });
              },
            ),
            const SizedBox(height: 20),
            if (loginWithEmail)
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            if (!loginWithEmail)
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(
                  labelText: 'Mobile',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
              ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: state.isLoading ? null : _login,
              child: state.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// import '../../../utils/custom_textfield.dart';
// import '../../../utils/primary_button.dart';
// import '../../../utils/theme/colors.dart';
// import '../../../utils/theme/textstyles.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../view_models/login_view_model.dart';

// class LoginView extends ConsumerStatefulWidget {
//   const LoginView({super.key});

//   @override
//   ConsumerState<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends ConsumerState<LoginView> {
//   @override
//   Widget build(BuildContext context) {
//     final viewModel = ref.watch(loginViewModelProvider.notifier);
//     final state = ref.watch(loginViewModelProvider);

//     return Scaffold(
//       bottomNavigationBar: PrimaryButton(
//         onTap: () {
//           if (state.isLoading) return;
//           viewModel.login();
//         },
//         buttonColor: colorBlack,
//         buttonName: "Login",
//         isLoading: state.isLoading,
//         isEnable: true,
//         isBottomBar: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const SizedBox(height: 50),
//             Text(
//               "Quiz App",
//               style:
//                   textStyles16BBOLD.copyWith(fontSize: 30, letterSpacing: 2.0),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 50),
//             viewModel.loginWithEmail
//                 ? CustomTextfield(
//                     lable: "Email",
//                     hintText: "Enter your email here...",
//                     controller: viewModel.emailController,
//                     validator: viewModel.emailValidator,
//                     keyboardType: TextInputType.emailAddress,
//                   )
//                 : CustomTextfield(
//                     lable: "Mobile",
//                     hintText: "Enter your mobile no here...",
//                     controller: viewModel.emailController, // Reusing for mobile
//                     keyboardType: TextInputType.phone,
//                   ),
//             const SizedBox(height: 20),
//             CustomTextfield(
//               lable: "Password",
//               hintText: "Enter your password here...",
//               controller: viewModel.passwordController,
//               validator: viewModel.passwordValidator,
//               obscureText: !viewModel.isPasswordVisible,
//               suffixIcon: IconButton(
//                 icon: Icon(
//                   viewModel.isPasswordVisible
//                       ? Icons.visibility
//                       : Icons.visibility_off,
//                 ),
//                 onPressed: viewModel.togglePasswordVisibility,
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextButton(
//               onPressed: viewModel.toggleLoginMethod,
//               child: Text(
//                 viewModel.loginWithEmail
//                     ? "Login with Mobile Number"
//                     : "Login with Email",
//               ),
//             ),
//             if (state.hasError)
//               Padding(
//                 padding: const EdgeInsets.only(top: 16.0),
//                 child: Text(
//                   state.error.toString(),
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
