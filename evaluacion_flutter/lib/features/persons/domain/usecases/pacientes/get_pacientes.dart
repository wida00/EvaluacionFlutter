import '../../../../../core/utils/typedef.dart';
import '../../entities/person.dart';
import '../../repositories/persons_repository.dart';

class GetPacientes {
  const GetPacientes(this._repository);

  final PersonsRepository _repository;

  ResultFuture<List<Person>> call() async {
    return _repository.getPacientes();
  }
}
