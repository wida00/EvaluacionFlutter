import '../../../../../core/utils/typedef.dart';
import '../../entities/person.dart';
import '../../repositories/persons_repository.dart';

class CreatePaciente {
  const CreatePaciente(this._repository);

  final PersonsRepository _repository;

  ResultFuture<void> call(Person params) async {
    return _repository.createPaciente(params);
  }
}
