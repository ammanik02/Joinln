import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionChangeController = StreamController<bool>.broadcast();

  Stream<bool> get connectionChange => _connectionChangeController.stream;

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    _connectionChangeController.add(hasConnection);
    return hasConnection;
  }

  void dispose() {
    _connectionChangeController.close();
  }
}
