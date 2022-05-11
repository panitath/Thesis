import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Leave {
  final int? id;
  final int? empcode;
  final String? firstname;
  final String? lastname;
  final String? leavetype;
  final DateTime? startdate;
  final DateTime? enddate;


  Leave(
  this.id,
  this.empcode,
  this.firstname,
  this.lastname,
  this.leavetype,
  this.startdate,
  this.enddate,

  );

  factory Leave.fromJson(Map<String, dynamic> json) {
    return Leave(
      json['id'] == null ? null : json["id"] as int,
      json['empcode'] == null ? null : json["empcode"] as int,
      json['firstname'] == null ? null : json["firstname"] as String,
      json['lastname'] == null ? null : json["lastname"] as String,
      json['leavetype'] == null ? null : json["leavetype"] as String,
      json['startdate'] == null ? null : json["startdate"] as DateTime,
      json['enddate'] == null ? null : json["enddate"] as DateTime,
    );
  }
}

class Users{
  String? emp_code;
  String? fname;
  String? lname;
  String? position_name;
  String? email;
  String? tel;
  String? group_code;
  String? group_name;
  String? field_code;
  String? field_name;
  String? dept_code;
  String? dept_name;
  String? center_code;
  String? center_name;
  String? zone_code;
  String? zone_name;
  String? division_code;
  String? division_name;
  String? sol_code;
  String? sol_name;
  String? stop_date;
  String? token;
  String? refreshToken;
  String? id_card;
  int? user_type;

  Users(
    this.emp_code,
    this.fname,
    this.lname,
    this.position_name,
    this.email,
    this.tel,
    this.group_code,
    this.group_name,
    this.field_code,
    this.field_name,
    this.dept_code,
    this.dept_name,
    this.center_code,
    this.center_name,
    this.zone_code,
    this.zone_name,
    this.division_code,
    this.division_name,
    this.sol_code,
    this.sol_name,
    this.stop_date,
    this.token,
    this.refreshToken,
    this.id_card,
    this.user_type,
  );

  Users.fromMap(Map<String, dynamic> map) {
    emp_code = map['emp_code'];
    fname = map['fname'];
    lname = map['lname'];
    position_name = map['position_name'];
    email = map['email'];
    tel = map['tel'];
    group_code = map['group_code'];
    group_name = map['group_name'];
    field_code = map['field_code'];
    field_name = map['field_name'];
    dept_code = map['dept_code'];
    dept_name = map['dept_name'];
    center_code = map['center_code'];
    center_name = map['center_name'];
    zone_code = map['zone_code'];
    zone_name = map['zone_name'];
    division_code = map['division_code'];
    division_name = map['division_name'];
    sol_code = map['sol_code'];
    sol_name = map['sol_name'];
    stop_date = map['stop_date'];
    token = map['token'];
    refreshToken = map['refreshToken'];
    id_card = map['id_card'];
    user_type = map['user_type'];
  }

  Users.fromMapObject(Map<dynamic, dynamic?> map) {
    emp_code = map['emp_code'] as String;
    fname = map['fname'] as String;
    lname = map['lname'] as String;
    position_name = map['position_name'] as String;
    email = map['email'] as String;
    tel = map['tel'] as String;
    group_code = map['group_code'] as String;
    group_name = map['group_name'] as String;
    field_code = map['field_code'] as String;
    field_name = map['field_name'] as String;
    dept_code = map['dept_code'] as String;
    dept_name = map['dept_name'] as String;
    center_code = map['center_code'] as String;
    center_name = map['center_name']as String;
    zone_code = map['zone_code']as String;
    zone_name = map['zone_name']as String;
    division_code = map['division_code']as String;
    division_name = map['division_name']!as String;
    sol_code = map['sol_code']as String;
    sol_name = map['sol_name']as String;
   stop_date = map['stop_date']!as String;
    token = map['token']as String;
    refreshToken = map['refreshToken']as String;
    id_card = map['id_card'] as String;
    user_type = map['user_type'] as int;
  }

  factory Users.fromJson(
    Map<String, dynamic> json,
  ) {
    return Users(
      json['emp_code'] == null ? null : json["emp_code"] as String,
      json['fname'] == null ? null : json["fname"] as String,
      json['lname'] == null ? null : json["lname"] as String,
      json['position_name'] == null ? null : json["position_name"] as String,
      json['email'] == null ? null : json["email"] as String,
      json['tel'] == null ? null : json["tel"] as String,
      json['group_code'] == null ? null : json["group_code"] as String,
      json['group_name'] == null ? null : json["group_name"] as String,
      json['field_code'] == null ? null : json["field_code"] as String,
      json['field_name'] == null ? null : json["field_name"] as String,
      json['dept_code'] == null ? null : json["dept_code"] as String,
      json['dept_name'] == null ? null : json["dept_name"] as String,
      json['center_code'] == null ? null : json["center_code"] as String,
      json['center_name'] == null ? null : json["center_name"] as String,
      json['zone_code'] == null ? null : json["zone_code"] as String,
      json['zone_name'] == null ? null : json["zone_name"] as String,
      json['division_code'] == null ? null : json["division_code"] as String,
      json['division_name'] == null ? null : json["division_name"] as String,
      json['sol_code'] == null ? null : json["sol_code"] as String,
      json['sol_name'] == null ? null : json["sol_name"] as String,
      json['stop_date'] == null ? null : json["stop_date"] as String,
      json['token'] == null ? null : json["token"] as String,
      json['refreshToken'] == null ? null : json["refreshToken"] as String,
      json['id_card'] == null ? null : json["id_card"] as String,
      json['user_type'] == null ? null : json["user_type"] as int,
    );
  }
}

class SingleUser {
  final Users user;
  SingleUser(this.user);

  factory SingleUser.fromJsonDB(QuerySnapshot s) {
    var user = s.docs.map((DocumentSnapshot ds) {
      return Users.fromJson(ds.data() as Map<String, dynamic>);
    });
    return SingleUser(user.first);
  }
}

class UserProvider extends ChangeNotifier{
  String? emp_code;
  String? fname;
  String? lname;
  String? position_name;
  String? email;
  String? tel;
  String? group_code;
  String? group_name;
  String? field_code;
  String? field_name;
  String? dept_code;
  String? dept_name;
  String? center_code;
  String? center_name;
  String? zone_code;
  String? zone_name;
  String? division_code;
  String? division_name;
  String? sol_code;
  String? sol_name;
  String? stop_date;
  String? token;
  String? refreshToken;
  String? id_card;
  int? user_type;

 String? get empcode => this.emp_code;

 set empcode(String? value){
   this.emp_code = value;
   notifyListeners();
 } 

  get getFname => this.fname;

 set setFname( fname) {
   this.fname = fname;
   notifyListeners();
 } 

  get getLname => this.lname;

 set setLname( lname) {
   this.lname = lname;
   notifyListeners();
 } 

  get positionname => this.position_name;

 set positionname( value) {
   this.position_name = value;
   notifyListeners();
 } 

  get getEmail => this.email;

 set setEmail( email) {
   this.email = email;
   notifyListeners();
 } 

  get getTel => this.tel;

 set setTel( tel) {
   this.tel = tel;
   notifyListeners();
 } 

  get groupcode => this.group_code;

 set groupcode( value) {
   this.group_code = value;
   notifyListeners();
 } 

  get groupname => this.group_name;

 set groupname( value) {
   this.group_name = value;
   notifyListeners();
 } 

  get fieldcode => this.field_code;

 set fieldcode( value) {
    this.field_code = value;
    notifyListeners();
 }

  get fieldname => this.field_name;

 set fieldname( value) {
   this.field_name = value;
   notifyListeners();
 } 

  get deptcode => this.dept_code;

 set deptcode( value) {
   this.dept_code = value;
   notifyListeners();
 } 

  get deptname => this.dept_name;

 set deptname( value) {
    this.dept_name = value;
    notifyListeners();
 }

  get centercode => this.center_code;

 set centercode( value) {
   this.center_code = value;
   notifyListeners();
 } 

  get centername => this.center_name;

 set centername( value) {
   this.center_name = value;
   notifyListeners();
 }

  get zonecode => this.zone_code;

 set zonecode( value) {
   this.zone_code = value;
    notifyListeners();
 } 

  get zonename => this.zone_name;

 set zonename( value) {
   this.zone_name = value;
   notifyListeners();
 } 

  get divisioncode => this.division_code;

 set divisioncode( value) {
   this.division_code = value;
   notifyListeners();
 } 

  get divisionname => this.division_name;

 set divisionname( value) {
   this.division_name = value;
   notifyListeners();
 } 

  get solcode => this.sol_code;

 set solcode( value) {
   this.sol_code = value;
   notifyListeners();
 } 
  get solname => this.sol_name;

 set solname( value) {
   this.sol_name = value;
   notifyListeners();
 } 

  get stopdate => this.stop_date;

 set stopdate( value) {
   this.stop_date = value;
    notifyListeners();
 } 

  get getToken => this.token;

 set setToken( token) {
   this.token = token;
   notifyListeners();
 } 

  get getRefreshToken => this.refreshToken;

 set setRefreshToken( refreshToken) {
   this.refreshToken = refreshToken;
   notifyListeners();
 } 

  get idcard => this.id_card;

 set idcard( value) {
   this.id_card = value;
   notifyListeners();
 } 

  get usertype => this.user_type;

 set usertype( value) {
   this.user_type = value;
   notifyListeners();
 } 
}
