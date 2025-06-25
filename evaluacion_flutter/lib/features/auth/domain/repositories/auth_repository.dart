import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  ResultFuture<User> login({
    required String username,
    required String password,
  });

  ResultFuture<void> logout();

  ResultFuture<User?> getCurrentUser();

  ResultFuture<bool> isLoggedIn();
}
