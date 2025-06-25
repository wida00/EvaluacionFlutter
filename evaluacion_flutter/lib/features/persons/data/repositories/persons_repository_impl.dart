import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/person.dart';
import '../../domain/repositories/persons_repository.dart';
import '../../../auth/presentation/providers/auth_state_providers.dart';
import '../datasources/persons_remote_data_source.dart';
import '../models/person_model.dart';

class PersonsRepositoryImpl implements PersonsRepository {
  const PersonsRepositoryImpl({
    required PersonsRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
    required Ref ref,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo,
       _ref = ref;

  final PersonsRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final Ref _ref;

  String? _getToken() {
    return _ref.read(tokenProvider);
  }

  // Pacientes
  @override
  ResultFuture<List<Person>> getPacientes() async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      final result = await _remoteDataSource.getPacientes(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<Person> getPacienteById(
    String tipoDocumento,
    String numeroDocumento,
  ) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      final result = await _remoteDataSource.getPacienteById(
        token,
        tipoDocumento,
        numeroDocumento,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> createPaciente(Person person) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      final personModel = PersonModel.fromEntity(person);
      await _remoteDataSource.createPaciente(token, personModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> updatePaciente(Person person) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      final personModel = PersonModel.fromEntity(person);
      await _remoteDataSource.updatePaciente(token, personModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deletePaciente(
    String tipoDocumento,
    String numeroDocumento,
  ) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      await _remoteDataSource.deletePaciente(
        token,
        tipoDocumento,
        numeroDocumento,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  // Médicos
  @override
  ResultFuture<List<Person>> getMedicos() async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      final result = await _remoteDataSource.getMedicos(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<Person> getMedicoById(
    String tipoDocumento,
    String numeroDocumento,
  ) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      final result = await _remoteDataSource.getMedicoById(
        token,
        tipoDocumento,
        numeroDocumento,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> createMedico(Person person) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      final personModel = PersonModel.fromEntity(person);
      await _remoteDataSource.createMedico(token, personModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> updateMedico(Person person) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      final personModel = PersonModel.fromEntity(person);
      await _remoteDataSource.updateMedico(token, personModel);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<void> deleteMedico(
    String tipoDocumento,
    String numeroDocumento,
  ) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final token = _getToken();
      if (token == null) {
        return const Left(AuthFailure('No authentication token'));
      }

      await _remoteDataSource.deleteMedico(
        token,
        tipoDocumento,
        numeroDocumento,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
