
import 'package:first_app/model/emp_leave.dart';
import 'package:flutter/material.dart';

class ClockProvider extends ChangeNotifier {
  int? empcode;
  DateTime? clocktime;
  String? currentlocation;
  DateTime? createdate;

List<ClockItem>? _empclockList;
  get empclockList => this._empclockList;

  set setempclockList(value) {
    this._empclockList = value;
    notifyListeners();
  }

get getempcode => this.empcode;

  set setempcode(empcode) {
    this.empcode = empcode;
    notifyListeners();
  }

  get getclocktime => this.clocktime;

  set setleaveid(clocktime) {
    this.clocktime = clocktime;
    notifyListeners();
  }

  get getcurrentlocation => this.currentlocation;

  set setcurrentlocation(currentlocation) {
    this.currentlocation = currentlocation;
    notifyListeners();
  }

  get getcreatedate => this.createdate;

  set setcreatedate(createdate) {
    this.createdate = createdate;
    notifyListeners();
  }

}



class ClockItem {
  final int empcode;
  final DateTime clocktime;
  final String currentlocation;
  final DateTime createdate;

  const ClockItem({
    Key? key,
    required this.empcode,
    required this.clocktime,
    required this.currentlocation,
    required this.createdate,
  });

  add(Map<String, String> map) {}
}


