import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity _connectivity;
 
  NetworkInfoImpl({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();
 
  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    // results is a List<ConnectivityResult> — connected if any interface
    // is not 'none'
    return results.any((r) => r != ConnectivityResult.none);
  }
}