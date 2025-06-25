import '../../../../../core/utils/typedef.dart';
import '../../repositories/persons_repository.dart';

class DeleteMedicoParams {
  const DeleteMedicoParams({
    required this.tipoDocumento,
    required this.numeroDocumento,
  });

  final String tipoDocumento;
  final String numeroDocumento;
}

class DeleteMedico {
  const DeleteMedico(this._repository);

  final PersonsRepository _repository;

  ResultFuture<void> call(DeleteMedicoParams params) async {
    return _repository.deleteMedico(
      params.tipoDocumento,
      params.numeroDocumento,
    );
  }
}
