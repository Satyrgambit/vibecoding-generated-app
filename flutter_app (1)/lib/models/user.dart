class User {
  final String userId;
  final String email;
  final String passwordHash;
  final String notificationPreferences;

  User({
    required this.userId,
    required this.email,
    required this.passwordHash,
    required this.notificationPreferences,
  });

  User copyWith({
    String? userId,
    String? email,
    String? passwordHash,
    String? notificationPreferences,
  }) {
    return User(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      notificationPreferences: notificationPreferences ?? this.notificationPreferences,
    );
  }
}
