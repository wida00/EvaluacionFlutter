import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import '../../data/repositories/auth_repository_impl.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/logout.dart';

// Data Sources
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.read(httpClientProvider));
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.read(authRemoteDataSourceProvider),
    networkInfo: ref.read(networkInfoProvider),
  );
});

// Use Cases
final loginUseCaseProvider = Provider<Login>((ref) {
  return Login(ref.read(authRepositoryProvider));
});

final logoutUseCaseProvider = Provider<Logout>((ref) {
  return Logout(ref.read(authRepositoryProvider));
});
