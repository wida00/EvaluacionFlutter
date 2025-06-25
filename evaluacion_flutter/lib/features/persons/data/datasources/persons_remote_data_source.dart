import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../../core/constants/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/typedef.dart';
import '../models/person_model.dart';

abstract class PersonsRemoteDataSource {
  Future<List<PersonModel>> getPacientes(String token);
  Future<PersonModel> getPacienteById(
    String token,
    String tipoDocumento,
    String numeroDocumento,
  );
  Future<void> createPaciente(String token, PersonModel person);
  Future<void> updatePaciente(String token, PersonModel person);
  Future<void> deletePaciente(
    String token,
    String tipoDocumento,
    String numeroDocumento,
  );

  Future<List<PersonModel>> getMedicos(String token);
  Future<PersonModel> getMedicoById(
    String token,
    String tipoDocumento,
    String numeroDocumento,
  );
  Future<void> createMedico(String token, PersonModel person);
  Future<void> updateMedico(String token, PersonModel person);
  Future<void> deleteMedico(
    String token,
    String tipoDocumento,
    String numeroDocumento,
  );
}

class PersonsRemoteDataSourceImpl implements PersonsRemoteDataSource {
  const PersonsRemoteDataSourceImpl(this._client);

  final http.Client _client;

  @override
  Future<List<PersonModel>> getPacientes(String token) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/paciente',
      );

      final response = await _client.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PersonModel.fromMap(json)).toList();
      } else {
        throw ServerException(
          'Failed to get pacientes: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error getting pacientes: $e');
    }
  }

  @override
  Future<PersonModel> getPacienteById(
    String token,
    String tipoDocumento,
    String numeroDocumento,
  ) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/paciente/$tipoDocumento/$numeroDocumento',
      );

      final response = await _client.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final DataMap data = json.decode(response.body);
        return PersonModel.fromMap(data);
      } else {
        throw ServerException('Failed to get paciente: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error getting paciente: $e');
    }
  }

  @override
  Future<void> createPaciente(String token, PersonModel person) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/paciente/',
      );

      final response = await _client.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(person.toMap()),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to create paciente: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error creating paciente: $e');
    }
  }

  @override
  Future<void> updatePaciente(String token, PersonModel person) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/paciente',
      );

      final response = await _client.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(person.toMap()),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to update paciente: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error updating paciente: $e');
    }
  }

  @override
  Future<void> deletePaciente(
    String token,
    String tipoDocumento,
    String numeroDocumento,
  ) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/paciente',
      );

      final response = await _client.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'tipoDocumento': tipoDocumento,
          'numeroDocumento': numeroDocumento,
        }),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to delete paciente: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error deleting paciente: $e');
    }
  }

  @override
  Future<List<PersonModel>> getMedicos(String token) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/medico',
      );

      final response = await _client.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => PersonModel.fromMap(json)).toList();
      } else {
        throw ServerException('Failed to get medicos: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error getting medicos: $e');
    }
  }

  @override
  Future<PersonModel> getMedicoById(
    String token,
    String tipoDocumento,
    String numeroDocumento,
  ) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/medico/$tipoDocumento/$numeroDocumento',
      );

      final response = await _client.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final DataMap data = json.decode(response.body);
        return PersonModel.fromMap(data);
      } else {
        throw ServerException('Failed to get medico: ${response.statusCode}');
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error getting medico: $e');
    }
  }

  @override
  Future<void> createMedico(String token, PersonModel person) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/medico',
      );

      final response = await _client.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(person.toMap()),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to create medico: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error creating medico: $e');
    }
  }

  @override
  Future<void> updateMedico(String token, PersonModel person) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/medico',
      );

      final response = await _client.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(person.toMap()),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to update medico: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error updating medico: $e');
    }
  }

  @override
  Future<void> deleteMedico(
    String token,
    String tipoDocumento,
    String numeroDocumento,
  ) async {
    try {
      final url = Uri.parse(
        '${AppConstants.baseUrl}${AppConstants.apiPath}/medico',
      );

      final response = await _client.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'tipoDocumento': tipoDocumento,
          'numeroDocumento': numeroDocumento,
        }),
      );

      if (response.statusCode != 200) {
        throw ServerException(
          'Failed to delete medico: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is ServerException) rethrow;
      throw NetworkException('Network error deleting medico: $e');
    }
  }
}
