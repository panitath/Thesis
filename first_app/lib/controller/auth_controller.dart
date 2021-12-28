import 'dart:async';
import 'package:first_app/model/resule_model.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/services/auth_service.dart';

class AuthController{
  final AuthService services;
  StreamController<bool> onSyncAuthController = StreamController<bool>.broadcast();
  Stream<bool> get onSyncAuth => onSyncAuthController.stream;
  bool _isDisposed = false;
  AuthController(this.services);

  
  Future<Result> RegisLogin(String firstname, String lastname, String email, String cid,String tel, String password) async {
      //add data to Authentication
      Result result = await services.regisLogin(firstname, lastname, email, cid, tel, password);

      //add data to firestore Database
      await services.addUserInfo(firstname, lastname, email, cid, tel, password);

      return result;
  }

  Future<Result> SignIn(String email, String password) async{
    return await services.signIn(email, password);
  }

  Future<Result> SignOut() async {
    return await services.signOut();
  }

  Future<UserProfileProvider> GetUserInfo(String email) async{
    if (_isDisposed) {
      onSyncAuthController = StreamController<bool>.broadcast();
    }
    onSyncAuthController.sink.add(true);
    var profile = await services.getUserInfo(email);
    onSyncAuthController.sink.add(false);
    dispose();
    return profile;
  }
  void dispose() {
    onSyncAuthController.close();
    _isDisposed = true;
  }

}