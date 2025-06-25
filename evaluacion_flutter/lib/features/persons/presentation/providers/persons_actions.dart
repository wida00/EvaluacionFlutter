import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/person.dart';
import '../../domain/usecases/medicos/delete_medico.dart';
import '../../domain/usecases/pacientes/delete_paciente.dart';
import 'persons_providers.dart';
import 'persons_state_providers.dart';

// Pacientes Actions
final loadPacientesActionProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final getPacientes = ref.read(getPacientesUseCaseProvider);

    ref.read(pacientesLoadingProvider.notifier).state = true;
    ref.read(pacientesErrorProvider.notifier).state = null;

    try {
      final result = await getPacientes();

      result.fold(
        (failure) {
          ref.read(pacientesLoadingProvider.notifier).state = false;
          ref.read(pacientesErrorProvider.notifier).state =
              failure.message ?? 'Error loading pacientes';
        },
        (pacientes) {
          ref.read(pacientesLoadingProvider.notifier).state = false;
          ref.read(pacientesListProvider.notifier).state = pacientes;
        },
      );
    } catch (e) {
      ref.read(pacientesLoadingProvider.notifier).state = false;
      ref.read(pacientesErrorProvider.notifier).state = 'Unexpected error: $e';
    }
  };
});

final createPacienteActionProvider = Provider<Future<bool> Function(Person)>((
  ref,
) {
  return (Person paciente) async {
    final createPaciente = ref.read(createPacienteUseCaseProvider);

    ref.read(isFormLoadingProvider.notifier).state = true;
    ref.read(formErrorProvider.notifier).state = null;

    try {
      final result = await createPaciente(paciente);

      return result.fold(
        (failure) {
          ref.read(isFormLoadingProvider.notifier).state = false;
          ref.read(formErrorProvider.notifier).state =
              failure.message ?? 'Error creating paciente';
          return false;
        },
        (_) {
          ref.read(isFormLoadingProvider.notifier).state = false;
          // Reload the list
          ref.read(loadPacientesActionProvider)();
          return true;
        },
      );
    } catch (e) {
      ref.read(isFormLoadingProvider.notifier).state = false;
      ref.read(formErrorProvider.notifier).state = 'Unexpected error: $e';
      return false;
    }
  };
});

final updatePacienteActionProvider = Provider<Future<bool> Function(Person)>((
  ref,
) {
  return (Person paciente) async {
    final updatePaciente = ref.read(updatePacienteUseCaseProvider);

    ref.read(isFormLoadingProvider.notifier).state = true;
    ref.read(formErrorProvider.notifier).state = null;

    try {
      final result = await updatePaciente(paciente);

      return result.fold(
        (failure) {
          ref.read(isFormLoadingProvider.notifier).state = false;
          ref.read(formErrorProvider.notifier).state =
              failure.message ?? 'Error updating paciente';
          return false;
        },
        (_) {
          ref.read(isFormLoadingProvider.notifier).state = false;
          // Reload the list
          ref.read(loadPacientesActionProvider)();
          return true;
        },
      );
    } catch (e) {
      ref.read(isFormLoadingProvider.notifier).state = false;
      ref.read(formErrorProvider.notifier).state = 'Unexpected error: $e';
      return false;
    }
  };
});

final deletePacienteActionProvider =
    Provider<Future<bool> Function(String, String)>((ref) {
      return (String tipoDocumento, String numeroDocumento) async {
        final deletePaciente = ref.read(deletePacienteUseCaseProvider);

        try {
          final result = await deletePaciente(
            DeletePacienteParams(
              tipoDocumento: tipoDocumento,
              numeroDocumento: numeroDocumento,
            ),
          );

          return result.fold(
            (failure) {
              ref.read(pacientesErrorProvider.notifier).state =
                  failure.message ?? 'Error deleting paciente';
              return false;
            },
            (_) {
              // Reload the list
              ref.read(loadPacientesActionProvider)();
              return true;
            },
          );
        } catch (e) {
          ref.read(pacientesErrorProvider.notifier).state =
              'Unexpected error: $e';
          return false;
        }
      };
    });

// Médicos Actions
final loadMedicosActionProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    final getMedicos = ref.read(getMedicosUseCaseProvider);

    ref.read(medicosLoadingProvider.notifier).state = true;
    ref.read(medicosErrorProvider.notifier).state = null;

    try {
      final result = await getMedicos();

      result.fold(
        (failure) {
          ref.read(medicosLoadingProvider.notifier).state = false;
          ref.read(medicosErrorProvider.notifier).state =
              failure.message ?? 'Error loading médicos';
        },
        (medicos) {
          ref.read(medicosLoadingProvider.notifier).state = false;
          ref.read(medicosListProvider.notifier).state = medicos;
        },
      );
    } catch (e) {
      ref.read(medicosLoadingProvider.notifier).state = false;
      ref.read(medicosErrorProvider.notifier).state = 'Unexpected error: $e';
    }
  };
});

final createMedicoActionProvider = Provider<Future<bool> Function(Person)>((
  ref,
) {
  return (Person medico) async {
    final createMedico = ref.read(createMedicoUseCaseProvider);

    ref.read(isFormLoadingProvider.notifier).state = true;
    ref.read(formErrorProvider.notifier).state = null;

    try {
      final result = await createMedico(medico);

      return result.fold(
        (failure) {
          ref.read(isFormLoadingProvider.notifier).state = false;
          ref.read(formErrorProvider.notifier).state =
              failure.message ?? 'Error creating médico';
          return false;
        },
        (_) {
          ref.read(isFormLoadingProvider.notifier).state = false;
          // Reload the list
          ref.read(loadMedicosActionProvider)();
          return true;
        },
      );
    } catch (e) {
      ref.read(isFormLoadingProvider.notifier).state = false;
      ref.read(formErrorProvider.notifier).state = 'Unexpected error: $e';
      return false;
    }
  };
});

final updateMedicoActionProvider = Provider<Future<bool> Function(Person)>((
  ref,
) {
  return (Person medico) async {
    final updateMedico = ref.read(updateMedicoUseCaseProvider);

    ref.read(isFormLoadingProvider.notifier).state = true;
    ref.read(formErrorProvider.notifier).state = null;

    try {
      final result = await updateMedico(medico);

      return result.fold(
        (failure) {
          ref.read(isFormLoadingProvider.notifier).state = false;
          ref.read(formErrorProvider.notifier).state =
              failure.message ?? 'Error updating médico';
          return false;
        },
        (_) {
          ref.read(isFormLoadingProvider.notifier).state = false;
          // Reload the list
          ref.read(loadMedicosActionProvider)();
          return true;
        },
      );
    } catch (e) {
      ref.read(isFormLoadingProvider.notifier).state = false;
      ref.read(formErrorProvider.notifier).state = 'Unexpected error: $e';
      return false;
    }
  };
});

final deleteMedicoActionProvider =
    Provider<Future<bool> Function(String, String)>((ref) {
      return (String tipoDocumento, String numeroDocumento) async {
        final deleteMedico = ref.read(deleteMedicoUseCaseProvider);

        try {
          final result = await deleteMedico(
            DeleteMedicoParams(
              tipoDocumento: tipoDocumento,
              numeroDocumento: numeroDocumento,
            ),
          );

          return result.fold(
            (failure) {
              ref.read(medicosErrorProvider.notifier).state =
                  failure.message ?? 'Error deleting médico';
              return false;
            },
            (_) {
              // Reload the list
              ref.read(loadMedicosActionProvider)();
              return true;
            },
          );
        } catch (e) {
          ref.read(medicosErrorProvider.notifier).state =
              'Unexpected error: $e';
          return false;
        }
      };
    });
