class AnonymousSignInState {
  final bool isLoading;
  final String? error;

  AnonymousSignInState({this.isLoading = false, this.error});

  AnonymousSignInState copyWith({bool? isLoading, String? error}) {
    return AnonymousSignInState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}
