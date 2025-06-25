import 'package:equatable/equatable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class Login extends UsecaseWithParams<User, LoginParams> {
  const Login(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<User> call(LoginParams params) async {
    return _repository.login(
      username: params.username,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  const LoginParams({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}
