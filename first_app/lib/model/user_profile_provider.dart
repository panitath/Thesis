import 'package:flutter/material.dart';

class UserProfileProvider extends ChangeNotifier{
  int? empcode;
  String? email;
  String? firstName;
   String? lastName;
  String? password;
  String? position;
  int? roleID;
  String? roleName;
  String? tel;
  String? grade;
  UserProfileProvider? _profile;

  get profile => this._profile;

  set profile(value) {
    this._profile = value;
    notifyListeners();
  }
  


 int? get getempcode => this.empcode;

 set setCid(int empcode) {
   this.empcode = empcode;
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

  get getGrade => this.grade;

 set getGrade( grade) {
   this.grade = grade;
   notifyListeners();
 } 
}