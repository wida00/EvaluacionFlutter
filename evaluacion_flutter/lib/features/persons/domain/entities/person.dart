import 'package:equatable/equatable.dart';

enum PersonType { paciente, medico }

class Person extends Equatable {
  const Person({
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.primerNombre,
    this.segundoNombre,
    this.primerApellido,
    this.segundoApellido,
    this.fechaExpedicionDocumento,
  });

  final String tipoDocumento;
  final String numeroDocumento;
  final String primerNombre;
  final String? segundoNombre;
  final String? primerApellido;
  final String? segundoApellido;
  final DateTime? fechaExpedicionDocumento;

  // Computed property for full name
  String get fullName {
    final parts = [
      primerNombre,
      segundoNombre,
      primerApellido,
      segundoApellido,
    ].where((part) => part != null && part.isNotEmpty).toList();
    return parts.join(' ');
  }

  // Computed property for document ID
  String get documentId => '$tipoDocumento-$numeroDocumento';

  @override
  List<Object?> get props => [
    tipoDocumento,
    numeroDocumento,
    primerNombre,
    segundoNombre,
    primerApellido,
    segundoApellido,
    fechaExpedicionDocumento,
  ];

  Person copyWith({
    String? tipoDocumento,
    String? numeroDocumento,
    String? primerNombre,
    String? segundoNombre,
    String? primerApellido,
    String? segundoApellido,
    DateTime? fechaExpedicionDocumento,
  }) {
    return Person(
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      numeroDocumento: numeroDocumento ?? this.numeroDocumento,
      primerNombre: primerNombre ?? this.primerNombre,
      segundoNombre: segundoNombre ?? this.segundoNombre,
      primerApellido: primerApellido ?? this.primerApellido,
      segundoApellido: segundoApellido ?? this.segundoApellido,
      fechaExpedicionDocumento:
          fechaExpedicionDocumento ?? this.fechaExpedicionDocumento,
    );
  }
}
