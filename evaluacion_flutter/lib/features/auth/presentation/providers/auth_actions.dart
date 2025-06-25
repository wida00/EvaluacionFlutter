import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/login.dart';
import 'auth_providers.dart';
import 'auth_state_providers.dart';

//
final loginActionProvider = Provider<Future<void> Function(String, String)>((ref) {
  return (String username, String password) async {
    final loginUseCase = ref.read(loginUseCaseProvider);
    
    // Set loading state
    ref.read(isLoadingProvider.notifier).state = true;
    ref.read(errorMessageProvider.notifier).state = null;
    
    try {
      final result = await loginUseCase(
        LoginParams(username: username, password: password),
      );
      
      result.fold(
        (failure) {
          // Handle error
          ref.read(isLoadingProvider.notifier).state = false;
          ref.read(errorMessageProvider.notifier).state = 
              failure.message ?? 'Login failed';
        },
        (user) {
          // Handle success
          ref.read(isLoadingProvider.notifier).state = false;
          ref.read(tokenProvider.notifier).state = user.token;
          ref.read(currentUserProvider.notifier).state = user;
          ref.read(errorMessageProvider.notifier).state = null;
        },
      );
    } catch (e) {
      ref.read(isLoadingProvider.notifier).state = false;
      ref.read(errorMessageProvider.notifier).state = 'Unexpected error: $e';
    }
  };
});


final logoutActionProvider = Provider<Future<void> Function()>((ref) {
  return () async {
    // Clear all state
    ref.read(tokenProvider.notifier).state = null;
    ref.read(currentUserProvider.notifier).state = null;
    ref.read(errorMessageProvider.notifier).state = null;
    ref.read(isLoadingProvider.notifier).state = false;
  };
});
