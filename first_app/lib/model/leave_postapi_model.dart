import 'leave_model.dart';

class LeavePostAPIModel {
final int? id;
  final String? empcode;
  final String? firstname;
  final String? lastname;
  final int? leavetype;
  final DateTime? startdate;
  final DateTime? enddate;
   final DateTime? createdate;
  

  LeavePostAPIModel(this.id, this.empcode, this.firstname, this.lastname, 
  this.leavetype, this.startdate, this.enddate, this.createdate);

  factory LeavePostAPIModel.fromJson(Map<String, dynamic> json) {
    return LeavePostAPIModel(

      json['id'] == null ? null : json["id"] as int,
      json['empcode'] == null ? null : json["empcode"] as String,
      json['firstname'] == null ? null : json["firstname"] as String,
      json['lastname'] == null ? null : json["lastname"] as String,
      json['leavetype'] == null ? null : json["leavetype"] as int,
      json['startdate'] == null ? null : json["startdate"] as DateTime,
      json['enddate'] == null ? null : json["enddate"] as DateTime,
      json['createdate'] == null ? null : json["createdate"] as DateTime,

      
    );
  }

  factory LeavePostAPIModel.fromDs(Map<String, Object?> json) {
    return LeavePostAPIModel(
        json['id'] == null ? null : json["id"] as int,
      json['empcode'] == null ? null : json["empcode"] as String,
      json['firstname'] == null ? null : json["firstname"] as String,
      json['lastname'] == null ? null : json["lastname"] as String,
      json['leavetype'] == null ? null : json["leavetype"] as int,
      json['startdate'] == null ? null : json["startdate"] as DateTime,
      json['enddate'] == null ? null : json["enddate"] as DateTime,
      json['createdate'] == null ? null : json["createdate"] as DateTime,
      
    );

}
factory LeavePostAPIModel.fromJsonDynamic(dynamic json) {
    return LeavePostAPIModel(
      json['id'] == null ? null : json["id"] as int,
      json['empcode'] == null ? null : json["empcode"] as String,
      json['firstname'] == null ? null : json["firstname"] as String,
      json['lastname'] == null ? null : json["lastname"] as String,
      json['leavetype'] == null ? null : json["leavetype"] as int,
      json['startdate'] == null ? null : DateTime.parse(json["startdate"]) as DateTime,
      json['enddate'] == null ? null : DateTime.parse(json["enddate"]) as DateTime,
      json['createdate'] == null ? null : DateTime.parse(json["createdate"]) as DateTime,
    );
}}


  