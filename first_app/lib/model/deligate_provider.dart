
import 'package:first_app/model/delegate.dart';
import 'package:flutter/material.dart';

class DelegateProvider extends ChangeNotifier {


  int? empcode;
  String? leavetype;
  int? empcodemanager;
  String? managername;
  DateTime? startdate;
  DateTime? enddate;
  int? empcodedelegate;
  String? delegatename;
  DateTime? createdate;

List<Delegate>? _delegateList;


  get delgateList => this._delegateList;

  set delegateList(value) {
    this._delegateList = value;
    notifyListeners();
  }

get getempcode => this.empcode;

  set setempcode(empcode) {
    this.empcode = empcode;
    notifyListeners();
  }

  get getleaveetype => this.leavetype;

  set setleavetype(leavetype) {
    this.leavetype = leavetype;
    notifyListeners();
  }


  get getempcodemanager => this.empcodemanager;

  set setempcodemanager(empcodemanager) {
    this.empcodemanager = empcodemanager;
    notifyListeners();
  } 

   get getmanagername => this.managername;

  set setemanagername(managername) {
    this.managername = managername;
    notifyListeners();
  } 

  get getstartdate => this.startdate;

  set setstartdate(startdate) {
    this.startdate = startdate;
    notifyListeners();
  }

  get getenddate => this.enddate;

  set setenddate(enddate) {
    this.enddate = enddate;
    notifyListeners();
  }

  get getempcodedelegate => this.empcodedelegate;
  set setempcodedelegate(empcodedelegate) {
    this.empcodedelegate = empcodedelegate;
    notifyListeners();
  }
}
