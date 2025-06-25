import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user.dart';


final tokenProvider = StateProvider<String?>((ref) => null);
final currentUserProvider = StateProvider<User?>((ref) => null);


final isLoadingProvider = StateProvider<bool>((ref) => false);
final errorMessageProvider = StateProvider<String?>((ref) => null);


final isAuthenticatedProvider = Provider<bool>((ref) {
  final token = ref.watch(tokenProvider);
  return token != null && token.isNotEmpty;
});
