import '../../../../core/utils/typedef.dart';
import '../entities/person.dart';

abstract class PersonsRepository {
  // Pacientes
  ResultFuture<List<Person>> getPacientes();
  ResultFuture<Person> getPacienteById(
    String tipoDocumento,
    String numeroDocumento,
  );
  ResultFuture<void> createPaciente(Person person);
  ResultFuture<void> updatePaciente(Person person);
  ResultFuture<void> deletePaciente(
    String tipoDocumento,
    String numeroDocumento,
  );

  // Médicos
  ResultFuture<List<Person>> getMedicos();
  ResultFuture<Person> getMedicoById(
    String tipoDocumento,
    String numeroDocumento,
  );
  ResultFuture<void> createMedico(Person person);
  ResultFuture<void> updateMedico(Person person);
  ResultFuture<void> deleteMedico(String tipoDocumento, String numeroDocumento);
}
