import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'dart:async';

import 'package:hive/screens/utils/snackbars/snacks.dart';

class ConnectionController extends GetxController {
  static ConnectionController instance = Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  String _status = 'waiting...';
  get getStatus => _status;

  set setStatus(String value) {
    _status = value;
    update();
  }

  bool _wasJustOffline = false;
  bool get getWasJustOffline => _wasJustOffline;

  void checkRealtimeConnection() async {
    var connectionResult = await _connectivity.checkConnectivity();
    if (connectionResult == ConnectivityResult.none && !_wasJustOffline) {
      _status = "Offline";
      _wasJustOffline = true;
      Snacks().connection_failed('Connection Status:', _status);
      update();
    }
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      switch (event) {
        case ConnectivityResult.mobile:
          {
            if (_wasJustOffline) {
              _status = "Connected to MobileData";
              Snacks().connection_success('Connection Status:', _status);
              _wasJustOffline = false;
              update();
            }
          }
          break;
        case ConnectivityResult.wifi:
          {
            if (_wasJustOffline) {
              _status = "Connected to Wifi";
              Snacks().connection_success('Connection Status:', _status);
              _wasJustOffline = false;
              update();
            }
          }
          break;
        case ConnectivityResult.ethernet:
          {
            if (_wasJustOffline) {
              _status = "Connected to WIfi";
              Snacks().connection_success('Connection Status:', _status);
              _wasJustOffline = false;
              update();
            }
          }
          break;
        case ConnectivityResult.none:
          {
            if (!_wasJustOffline) {
              _status = "Offline";
              Snacks().connection_failed('Connection Status:', _status);
              _wasJustOffline = true;
              update();
            }
          }
          break;
      }
    });
  }
}
