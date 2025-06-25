import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../network/network_info.dart';

// Core providers
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return NetworkInfoImpl();
});

final httpClientProvider = Provider<http.Client>((ref) {
  return http.Client();
});
