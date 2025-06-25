import '../../../../core/usecase/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../repositories/auth_repository.dart';

class Logout extends UsecaseWithoutParams<void> {
  const Logout(this._repository);

  final AuthRepository _repository;

  @override
  ResultFuture<void> call() async {
    return _repository.logout();
  }
}
