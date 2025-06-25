import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/person.dart';

// Pacientes State Providers
final pacientesListProvider = StateProvider<List<Person>>((ref) => []);
final pacientesLoadingProvider = StateProvider<bool>((ref) => false);
final pacientesErrorProvider = StateProvider<String?>((ref) => null);

// Médicos State Providers
final medicosListProvider = StateProvider<List<Person>>((ref) => []);
final medicosLoadingProvider = StateProvider<bool>((ref) => false);
final medicosErrorProvider = StateProvider<String?>((ref) => null);

// Selected person for editing/viewing
final selectedPersonProvider = StateProvider<Person?>((ref) => null);

// Form state
final isFormLoadingProvider = StateProvider<bool>((ref) => false);
final formErrorProvider = StateProvider<String?>((ref) => null);
