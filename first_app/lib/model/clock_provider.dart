
import 'package:first_app/model/emp_leave.dart';
import 'package:flutter/material.dart';

class ClockProvider extends ChangeNotifier {
  int? empcode;
  DateTime? clocktime;
  String? currentlocation;
  DateTime? createdate;
  DateTime? fromDate;
  DateTime? toDate;

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

  set setclocktime(clocktime) {
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

    get getfromDate => this.fromDate;

  set setfromDate(fromDate) {
    this.fromDate = fromDate;
    notifyListeners();
  }

  get gettoDate => this.toDate;

  set settoDate(toDate) {
    this.toDate = toDate;
    notifyListeners();
  }

}



class ClockItem {
  final int empcode;
  final DateTime clocktime;
  final String currentlocation;
  final DateTime createdate;
   final DateTime fromDate;
    final DateTime toDate;

  const ClockItem({
    Key? key,
    required this.empcode,
    required this.clocktime,
    required this.currentlocation,
    required this.createdate,
    required this.fromDate,
    required this.toDate,
  });

  add(Map<String, String> map) {}
}


