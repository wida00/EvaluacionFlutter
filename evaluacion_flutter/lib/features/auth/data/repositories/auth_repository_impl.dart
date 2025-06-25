import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _networkInfo = networkInfo;

  final AuthRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<User> login({
    required String username,
    required String password,
  }) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(NetworkFailure('No internet connection'));
      }

      final result = await _remoteDataSource.login(
        username: username,
        password: password,
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
  ResultFuture<void> logout() async {
    try {
      if (await _networkInfo.isConnected) {
        await _remoteDataSource.logout();
      }
      return const Right(null);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  ResultFuture<User?> getCurrentUser() async {
    // This will be handled by StateProvider
    return const Right(null);
  }

  @override
  ResultFuture<bool> isLoggedIn() async {
    // This will be handled by StateProvider
    return const Right(false);
  }
}
