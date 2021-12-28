import 'dart:collection';

import 'package:flutter/material.dart';

import 'user_class_model.dart';

class UserProvider with ChangeNotifier {
  int? id_card;
  String? first_name;
  String? last_name;
  String? tel;
  String? email;
  String? password;
  String? position;
  int? roleId;
  String? roleName;
  int? hospitalId;
  String? hospitalName;
  List<User>? _userList;
  UserProvider? user;

  UserProvider? get getUser => this.user;
  set setUser(UserProvider? user) {
    this.user = user;
    notifyListeners();
  } 

  get idcard => this.id_card;

  set idcard(value) {
    this.id_card = value;
    notifyListeners();
  }

  get firstname => this.first_name;

  set firstname(value) {
    this.first_name = value;
    notifyListeners();
  }

  get lastname => this.last_name;

  set lastname(value) {
    this.last_name = value;
    notifyListeners();
  }

  get getTel => this.tel;

  set setTel(tel) {
    this.tel = tel;
    notifyListeners();
  }

  get getEmail => this.email;

  set setEmail(email) {
    this.email = email;
    notifyListeners();
  }

  get getPassword => this.password;

  set setPassword(password) {
    this.password = password;
    notifyListeners();
  }

  get getPosition => this.position;

  set setPosition(position) {
    this.position = position;
    notifyListeners();
  }

  get getRoleId => this.roleId;

  set setRoleId(roleId) {
    this.roleId = roleId;
    notifyListeners();
  }

  get getRoleName => this.roleName;

  set setRoleName(roleName) {
    this.roleName = roleName;
    notifyListeners();
  }

  get getHospitalId => this.hospitalId;

  set setHospitalId(hospitalId) {
    this.hospitalId = hospitalId;
    notifyListeners();
  }

  get getHospitalName => this.hospitalName;

  set setHospitalName(hospitalName) {
    this.hospitalName = hospitalName;
    notifyListeners();
  }

  get userList => this._userList;

  set userList(value) {
    this._userList = value;
    notifyListeners();
  }

  final List<User> _item = [];

  UnmodifiableListView<User> get items => UnmodifiableListView(_item);

  List<User> getBookingList() {
    return _item;
  }

  void AddUserList(User item) {
    _item.add(item);
    notifyListeners();
  }

  void RemoveUserList(User item) {
    _item.remove(item);
    notifyListeners();
  }

  // List<User> users = [];

  // List<User> getUser() {
  //   return users;
  // }

  //void addUser(User statement) {
    //users.add(statement);

    //users.insert(0, statement); เพิ่มด้านบน
    //users.add(statement); เพิ่มด้านล่าง
    //notifyListeners();
// แจ้ง consumer
  //}
}