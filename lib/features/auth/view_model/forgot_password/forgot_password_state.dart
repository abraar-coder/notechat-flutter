class ForgotPasswordState {
  final String email;
  final bool isLoading;
  final String? emailError;
  final String? error;

  ForgotPasswordState({
    this.email = '',
    this.isLoading = false,
    this.emailError,
    this.error,
  });

  ForgotPasswordState copyWith({
    String? email,
    bool? isLoading,
    String? emailError,
    String? error,
  }) {
    return ForgotPasswordState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      emailError: emailError ?? this.emailError,
      error: error ?? this.error,
    );
  }
}
