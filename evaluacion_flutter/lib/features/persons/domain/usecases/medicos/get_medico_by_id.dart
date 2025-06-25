import '../../../../../core/utils/typedef.dart';
import '../../entities/person.dart';
import '../../repositories/persons_repository.dart';

class GetMedicoByIdParams {
  const GetMedicoByIdParams({
    required this.tipoDocumento,
    required this.numeroDocumento,
  });

  final String tipoDocumento;
  final String numeroDocumento;
}

class GetMedicoById {
  const GetMedicoById(this._repository);

  final PersonsRepository _repository;

  ResultFuture<Person> call(GetMedicoByIdParams params) async {
    return _repository.getMedicoById(
      params.tipoDocumento,
      params.numeroDocumento,
    );
  }
}
