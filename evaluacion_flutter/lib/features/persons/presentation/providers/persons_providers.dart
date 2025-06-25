import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/persons_remote_data_source.dart';
import '../../data/repositories/persons_repository_impl.dart';
import '../../domain/repositories/persons_repository.dart';
import '../../domain/usecases/medicos/create_medico.dart';
import '../../domain/usecases/medicos/delete_medico.dart';
import '../../domain/usecases/medicos/get_medico_by_id.dart';
import '../../domain/usecases/medicos/get_medicos.dart';
import '../../domain/usecases/medicos/update_medico.dart';
import '../../domain/usecases/pacientes/create_paciente.dart';
import '../../domain/usecases/pacientes/delete_paciente.dart';
import '../../domain/usecases/pacientes/get_paciente_by_id.dart';
import '../../domain/usecases/pacientes/get_pacientes.dart';
import '../../domain/usecases/pacientes/update_paciente.dart';

// Data Sources
final personsRemoteDataSourceProvider = Provider<PersonsRemoteDataSource>((
  ref,
) {
  return PersonsRemoteDataSourceImpl(ref.read(httpClientProvider));
});

// Repository
final personsRepositoryProvider = Provider<PersonsRepository>((ref) {
  return PersonsRepositoryImpl(
    remoteDataSource: ref.read(personsRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
    ref: ref,
  );
});

// Pacientes Use Cases
final getPacientesUseCaseProvider = Provider<GetPacientes>((ref) {
  return GetPacientes(ref.read(personsRepositoryProvider));
});

final getPacienteByIdUseCaseProvider = Provider<GetPacienteById>((ref) {
  return GetPacienteById(ref.read(personsRepositoryProvider));
});

final createPacienteUseCaseProvider = Provider<CreatePaciente>((ref) {
  return CreatePaciente(ref.read(personsRepositoryProvider));
});

final updatePacienteUseCaseProvider = Provider<UpdatePaciente>((ref) {
  return UpdatePaciente(ref.read(personsRepositoryProvider));
});

final deletePacienteUseCaseProvider = Provider<DeletePaciente>((ref) {
  return DeletePaciente(ref.read(personsRepositoryProvider));
});

// Médicos Use Cases
final getMedicosUseCaseProvider = Provider<GetMedicos>((ref) {
  return GetMedicos(ref.read(personsRepositoryProvider));
});

final getMedicoByIdUseCaseProvider = Provider<GetMedicoById>((ref) {
  return GetMedicoById(ref.read(personsRepositoryProvider));
});

final createMedicoUseCaseProvider = Provider<CreateMedico>((ref) {
  return CreateMedico(ref.read(personsRepositoryProvider));
});

final updateMedicoUseCaseProvider = Provider<UpdateMedico>((ref) {
  return UpdateMedico(ref.read(personsRepositoryProvider));
});

final deleteMedicoUseCaseProvider = Provider<DeleteMedico>((ref) {
  return DeleteMedico(ref.read(personsRepositoryProvider));
});
