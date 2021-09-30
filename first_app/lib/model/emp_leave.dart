import 'package:flutter/material.dart';


 class Empleave extends ChangeNotifier{
 String? leaveid;
 DateTime? startdate;
 DateTime? enddate;
 String? comment;
//  notifyListener();

   Empleave({this.leaveid,this.startdate, this.enddate, this.comment});

// get leaveid => this.leaveid;

//   set leaveid(value) {
//     this.leaveid = value;
//     notifyListeners();
//   } 

//   get startdate => this._startdate;

//   set startdate(value) {
//     this._startdate = value;
//     notifyListeners();
//   } 

//   get enddate => this._enddate;

//   set enddate(value) {
//     this._enddate = value;
//     notifyListeners();}

//  get comment => this._comment;

//   set comment(value) {
//     this._comment = value;
    notifyListeners();

// }
}

