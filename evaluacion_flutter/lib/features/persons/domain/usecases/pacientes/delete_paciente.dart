import '../../../../../core/utils/typedef.dart';
import '../../repositories/persons_repository.dart';

class DeletePacienteParams {
  const DeletePacienteParams({
    required this.tipoDocumento,
    required this.numeroDocumento,
  });

  final String tipoDocumento;
  final String numeroDocumento;
}

class DeletePaciente {
  const DeletePaciente(this._repository);

  final PersonsRepository _repository;

  ResultFuture<void> call(DeletePacienteParams params) async {
    return _repository.deletePaciente(
      params.tipoDocumento,
      params.numeroDocumento,
    );
  }
}
