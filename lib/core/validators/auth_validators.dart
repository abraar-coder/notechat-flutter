class AuthValidators {
  static final _emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final _passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~]).{8,}$',
  );

  static String? validateEmail(String email) {
    if (email.trim().isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(email.trim())) return 'Enter a valid email';
    return null;
  }

  static String? validatePassword(String password) {
    if (password.trim().isEmpty) return 'Password is required';
    if (!_passwordRegex.hasMatch(password.trim())) {
      return 'Password must be at least 8 characters,\ninclude uppercase, lowercase,\ndigit and special character.';
    }
    return null;
  }

  static String? validateConfirmPassword(
    String password,
    String confirmPassword,
  ) {
    if (confirmPassword.trim().isEmpty) return 'Confirm password is required';
    if (password.trim() != confirmPassword.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }
}
