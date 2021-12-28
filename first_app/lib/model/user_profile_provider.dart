import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier{
  late String cid;
  String? email;
  String? firstName;
  int? hospitalID;
  String? hospitalName;
  String? lastName;
  String? password;
  String? position;
  int? roleID;
  String? roleName;
  String? tel;
  UserProfileProvider? _profile;

  get profile => this._profile;

  set profile(value) {
    this._profile = value;
    notifyListeners();
  }
  
//   UserProfileProvider? get getProfile => this.profile;

//  set setProfile(UserProfileProvider? profile) {
//    this.profile = profile;
//    notifyListeners();
//  } 

 String? get getCid => this.cid;

 set setCid(String cid) {
   this.cid = cid;
   notifyListeners();
 } 

  get getEmail => this.email;

 set setEmail( email) {
   this.email = email;
   notifyListeners();
 } 

  get getFirstName => this.firstName;

 set setFirstName( firstName) {
  this.firstName = firstName;
  notifyListeners();
 } 

  get getHospitalID => this.hospitalID;

 set setHospitalID( hospitalID) {
  this.hospitalID = hospitalID;
  notifyListeners();
 } 

  get getHospitalName => this.hospitalName;

 set setHospitalName( hospitalName) {
   this.hospitalName = hospitalName;
   notifyListeners();
 } 

  get getLastName => this.lastName;

 set setLastName( lastName) {
  this.lastName = lastName;
  notifyListeners();
 } 

  get getPassword => this.password;

 set setPassword( password) {
   this.password = password;
   notifyListeners();
 } 

  get getPosition => this.position;

 set setPosition( position) {
   this.position = position;
   notifyListeners();
 } 

  get getRoleID => this.roleID;

 set setRoleID( roleID) {
  this.roleID = roleID;
  notifyListeners();
 }

  get getRoleName => this.roleName;

 set setRoleName( roleName) {
   this.roleName = roleName;
    notifyListeners();
 } 

  get getTel => this.tel;

 set setTel( tel) {
   this.tel = tel;
   notifyListeners();
 } 
}