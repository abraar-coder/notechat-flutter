class RegisterState {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final String? generalError;

  final String? emailError;
  final String? passwordError;
  final String? confirmPasswordError;

  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;

  RegisterState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.generalError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
  });

  RegisterState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    String? generalError,
    String? emailError,
    String? passwordError,
    String? confirmPasswordError,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      generalError: generalError,
      emailError: emailError,
      passwordError: passwordError,
      confirmPasswordError: confirmPasswordError,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible: isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
    );
  }
}
