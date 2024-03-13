import 'dart:async';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';


class BaseViewModel extends ChangeNotifier {
  bool _isLoading = false;
  String _loadingString = "";
  bool _isDisposed = false;
  bool _isInitializeDone = false;

  bool get isLoading => _isLoading;

  String get loadingString => _loadingString;

  bool get isDisposed => _isDisposed;

  bool get isInitialized => _isInitializeDone;


  BaseViewModel() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _init();
      log("init called VM...");
    });
  }

  FutureOr<void> initState() {
    // TODO: implement initState
    throw UnimplementedError();
  }

  FutureOr<void> disposeState() {
    // TODO: implement disposeState
    throw UnimplementedError();
  }

  void _init() async {
    // _initState = initState();
    // await _initState;
    _isInitializeDone = true;
    initState();
  }

  changeState() {
    notifyListeners();
  }

  changeLoaderStatus(bool status, String loadingString) {
    _isLoading = status;
    _loadingString = loadingString;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    disposeState();
    super.dispose();
  }
}