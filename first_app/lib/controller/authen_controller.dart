
import 'dart:async';

import 'package:first_app/model/authen_api_model.dart';
import 'package:first_app/model/emp_api_model.dart';
import 'package:first_app/model/leave_postapi_model.dart';
import 'package:first_app/services/api_service.dart';


class EAuthenController {
  final IEAuthenServices services;
  StreamController<bool> onSyncController = StreamController(); //<bool>.broadcast();
  Stream<bool> get onSync => onSyncController.stream;

  EAuthenController(this.services);

  Future<AuthenModel> authentication(String username, String password) async {
    onSyncController.add(true);
    AuthenModel model = await services.authentication(username, password);
    await services.addUser(model);
    onSyncController.add(false);
    return model;
  }

 Future<List<LeavePostAPIModel>> getleave(int empcode) async {
    onSyncController.add(true);
    var model = await services.getleave(empcode);
    onSyncController.add(false);
    return model;
  }

  Future<LeavePostAPIModel> postleave(int empcode, String firstname,String lastname,
  int leavetype,DateTime startdate,DateTime enddate ) 
 
  async { 
    String start = startdate.toString();
    String end = enddate.toString();
    

    onSyncController.add(true);
    LeavePostAPIModel model = await services.postleave(empcode,firstname,lastname,leavetype,start,end);
    onSyncController.add(false);
    return model;
  }

// Future<EmpAPIModel> getemp(int empcode) async {
//     onSyncController.add(true);
//     var model = await services.getemp( empcode);
//     onSyncController.add(false);
//     return model;
//   }
 

}
