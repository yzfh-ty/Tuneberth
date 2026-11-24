/// Credentials issued by the official authorization flow.
///
/// Token values must not be included in logs, UI state, or music databases.
final class AuthTokens {
  const AuthTokens({
    required this.accessToken,
    required this.refreshToken,
    this.expiresAt,
  });

  final String accessToken;
  final String refreshToken;
  final DateTime? expiresAt;

  @override
  String toString() => 'AuthTokens(redacted)';
}
