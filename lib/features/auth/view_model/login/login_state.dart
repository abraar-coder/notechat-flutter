class LoginState {
  final String email;
  final String password;
  final bool isLoading;
  final String? generalError;
  final String? emailError;
  final String? passwordError;
  final bool isPasswordVisible; // 👈

  LoginState({
    this.email = '',
    this.password = '',
    this.isLoading = false,
    this.generalError,
    this.emailError,
    this.passwordError,
    this.isPasswordVisible = false, // 👈 default is hidden
  });

  LoginState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? generalError,
    String? emailError,
    String? passwordError,
    bool? isPasswordVisible, // 👈
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      generalError: generalError,
      emailError: emailError,
      passwordError: passwordError,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
