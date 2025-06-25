import '../../../../core/utils/typedef.dart';
import '../../domain/entities/person.dart';

class PersonModel extends Person {
  const PersonModel({
    required super.tipoDocumento,
    required super.numeroDocumento,
    required super.primerNombre,
    super.segundoNombre,
    super.primerApellido,
    super.segundoApellido,
    super.fechaExpedicionDocumento,
  });

  factory PersonModel.fromMap(DataMap map) {
    return PersonModel(
      tipoDocumento: map['tipoDocumento'] ?? '',
      numeroDocumento: map['numeroDocumento'] ?? '',
      primerNombre: map['primerNombre'] ?? '',
      segundoNombre: map['segundoNombre'],
      primerApellido: map['primerApellido'],
      segundoApellido: map['segundoApellido'],
      fechaExpedicionDocumento: map['fechaExpedicionDocumento'] != null
          ? DateTime.tryParse(map['fechaExpedicionDocumento'].toString())
          : null,
    );
  }

  factory PersonModel.fromEntity(Person person) {
    return PersonModel(
      tipoDocumento: person.tipoDocumento,
      numeroDocumento: person.numeroDocumento,
      primerNombre: person.primerNombre,
      segundoNombre: person.segundoNombre,
      primerApellido: person.primerApellido,
      segundoApellido: person.segundoApellido,
      fechaExpedicionDocumento: person.fechaExpedicionDocumento,
    );
  }

  DataMap toMap() {
    return {
      'tipoDocumento': tipoDocumento,
      'numeroDocumento': numeroDocumento,
      'primerNombre': primerNombre,
      'segundoNombre': segundoNombre,
      'primerApellido': primerApellido,
      'segundoApellido': segundoApellido,
      'fechaExpedicionDocumento': fechaExpedicionDocumento
          ?.toIso8601String()
          .split('T')[0], // Format as YYYY-MM-DD
    };
  }

  @override
  PersonModel copyWith({
    String? tipoDocumento,
    String? numeroDocumento,
    String? primerNombre,
    String? segundoNombre,
    String? primerApellido,
    String? segundoApellido,
    DateTime? fechaExpedicionDocumento,
  }) {
    return PersonModel(
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
