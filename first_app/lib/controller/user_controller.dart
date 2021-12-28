
import 'dart:async';

import 'package:first_app/model/user_class_model.dart';
import 'package:first_app/services/user_service.dart';


class UserController {
  final UserServices services;
  List<User> users = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  UserController(this.services);
   bool _isDisposed = false;

  Future<List<User>> fecthUsers() async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    users = await services.getUsers();
    onSyncController.add(false);
    dispose();
    return users;
  }

  void addUser(User items) async {
    services.addUser(items);
  }

  void dispose() {
    onSyncController.close();
    _isDisposed = true;
  }
}