
import 'package:first_app/model/deligate.dart';
import 'package:flutter/material.dart';

class DeligateFormmodel extends ChangeNotifier {
  String? empname;
  String? leaveid;
  DateTime? startdate;
  DateTime? enddate;
  String? empdeligate;

List<Deligate>? _deligateList;


  get deligateList => this._deligateList;

  set deligateList(value) {
    this._deligateList = value;
    notifyListeners();
  }

  get getleaveid => this.leaveid;

  set setleaveid(leaveid) {
    this.leaveid = leaveid;
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

  get getempdeligate => this.empdeligate;
  set setempdeligate(empdeligate) {
    this.empdeligate = empdeligate;
    notifyListeners();
  }
}
