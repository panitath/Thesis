
import 'package:first_app/model/emp_leave.dart';
import 'package:flutter/material.dart';

class EmpleavelistFormmodel extends ChangeNotifier {
  String? leaveid;
  DateTime? startdate;
  DateTime? enddate;
  String? comment;

  //Empleave({this.leaveid,this.startdate, this.enddate, this.comment});
List<Empleave>? _empleaveList;


  get empleaveList => this._empleaveList;

  set empleaveList(value) {
    this._empleaveList = value;
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

  get getcomment => this.comment;

  set setcomment(comment) {
    this.comment = comment;
    notifyListeners();
  }
}
