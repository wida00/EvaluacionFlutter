import '../../../../../core/utils/typedef.dart';
import '../../entities/person.dart';
import '../../repositories/persons_repository.dart';

class GetPacienteByIdParams {
  const GetPacienteByIdParams({
    required this.tipoDocumento,
    required this.numeroDocumento,
  });

  final String tipoDocumento;
  final String numeroDocumento;
}

class GetPacienteById {
  const GetPacienteById(this._repository);

  final PersonsRepository _repository;

  ResultFuture<Person> call(GetPacienteByIdParams params) async {
    return _repository.getPacienteById(
      params.tipoDocumento,
      params.numeroDocumento,
    );
  }
}
