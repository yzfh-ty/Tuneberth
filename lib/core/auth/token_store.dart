import 'auth_tokens.dart';

/// Platform-secure credential storage; no plaintext implementation is provided.
abstract interface class TokenStore {
  Future<AuthTokens?> read();
  Future<void> write(AuthTokens tokens);
  Future<void> clear();
}
