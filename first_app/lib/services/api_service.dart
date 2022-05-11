import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:first_app/model/authen_api_model.dart';
import 'package:first_app/model/emp_api_model.dart';
import 'package:first_app/model/employee.dart';
import 'package:first_app/model/leave_model.dart';
import 'package:first_app/model/leave_postapi_model.dart';
import 'package:first_app/services/database_helper.dart';
import 'package:http/http.dart' as http;

abstract class IEAuthenServices {
  Future<AuthenModel> authentication(String username, String password);
  Future<void> addUser(AuthenModel model);
  Future<List<LeavePostAPIModel>> getleave(int empcode);
  Future<LeavePostAPIModel> postleave(int empcode, String firstname,
      String lastname, int leavetype, String startdate, String enddate);
  
}

class EAuthenServices extends IEAuthenServices {
  Users? user;

  Future<AuthenModel> authentication(String username, String password) async {
    var url = "https://apitest.ghb.co.th/extimeservice/api/Authenticate/login";
    Map jsonData = {"username": username, "password": password};
    var body = json.encode(jsonData);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    var data = AuthenModel.fromJson(
      json.decode(response.body),
    );
    return data;
  }

  Future<void> addUser(AuthenModel model) async {
    await DBLHelper.insertUserEmpployee(model);
  }

  Future<List<LeavePostAPIModel>> getleave(int empcode) async {
    var url = "https://apitest.ghb.co.th/extimeservice/api/Leave/emp_code";

    final user = await DBLHelper.getToken();
    Map jsonData = {
      "accessToken": user[0]['token'],
      //"refreshToken": user[0]['refreshToken']
      "empcode" : empcode
    };
    var body = json.encode(jsonData);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    var jsonD = jsonDecode(response.body)['data'] as List;
    List<LeavePostAPIModel> data =
        jsonD.map((data) => LeavePostAPIModel.fromJsonDynamic(data)).toList();

    return data;
  }

  Future<LeavePostAPIModel> postleave(
      int empcode,
      String firstname,
      String lastname,
      int leavetype,
      String startdate,
      String enddate) async {
    var url = "https://apitest.ghb.co.th/extimeservice/api/Leave";

    final user = await DBLHelper.getToken();
    Map jsonData = {
      "empcode": empcode,
      "firstname": firstname,
      "lastname": lastname,
      "leavetype": leavetype,
      "startdate": startdate.toString(),
      "enddate": enddate.toString(),
      "createdate": DateTime.now().toString(),
      "accessToken": user[0]['token'],
      "refreshToken": user[0]['refreshToken']
    };
    var body = json.encode(jsonData);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    var data = LeavePostAPIModel.fromJson(
      json.decode(response.body),
    );
    return data;
  }


}
