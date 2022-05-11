import 'package:first_app/model/emp_model.dart';

class AuthenModel {
  final String? token;
  final APIEmployee? employee;
  final String? refreshToken;
  final bool? status;
  final String? message;
  

  AuthenModel(this.token, this.employee, this.refreshToken, this.status, this.message);

  factory AuthenModel.fromJson(Map<String, dynamic> json) {
    return AuthenModel(
      json['token'] == null ? null : json["token"] as String,
      json['data'] == null ? null : APIEmployee.fromJson(json['data']),
      json['refreshToken'] == null ? null : json["refreshToken"] as String,
      json['status'] == null ? false : json["status"] as bool,
      json['message'] == null ? null : json["message"] as String,
    );
  }
}
