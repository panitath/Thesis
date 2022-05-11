import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/delegate_model.dart';
import 'package:first_app/model/emp_api_model.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/employee.dart';
import 'package:first_app/services/database_helper.dart';
import 'package:http/http.dart' as http;

abstract class Services {
  Future<List<Empleave>> getEmpleaves();
  Future<List<Empleave>> getEmpleaveList();
  Future<void> addEmpLeave(Empleave items);
  Future<void> deleteEmpleave(
      int _empcode, String _leavetype, DateTime _startdate, DateTime _enddate);
  Future<void> addDelegate(Delegate ss);
  Future<List<Empleave>> getapprovedList(int _empcodemanager, String _status);
  Future<List<Empleave>> getapprovedListAll(int _empcodemanager);
  Future<void> updateapproved(
      int _empcode,
      int _empcodemanager,
      String _leavetype,
      DateTime _startdate,
      DateTime _enddate,
      String _status);
  Future<Employee> getEmpDelegate(int empcodedelegate);
  Future<List<Delegate>> getEmpDelegateList(
      int _empcode);
  Future<EmpAPIModel> getemp(int empcode);
   Future<Delegate> checkEmpDelegate(String empcode, String leavetype,
                                              DateTime fromDate,DateTime toDate) ;
}

class EmpleaveServices extends Services {
  CollectionReference _ref = FirebaseFirestore.instance.collection('LEAVE');
  CollectionReference _refdelegate =
      FirebaseFirestore.instance.collection('DELEGATE');
  @override
  Future<List<Empleave>> getEmpleaves() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('LEAVE').get();

    AllEmpleaves empleaves = AllEmpleaves.fromSnapshot(snapshot);
    return empleaves.empleaves;
  }

  @override
  Future<List<Empleave>> getEmpleaveList() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('LEAVE').get();
    AllEmpleaveList empleaves = AllEmpleaveList.fromSnapshot(snapshot);
    return empleaves.leavelist;
  }

  @override
  Future<void> addEmpLeave(Empleave items) {
    return _ref.add({
      'empcode': items.empcode,
      'leaveid': items.leaveid,
      'leavetype': items.leavetype,
      'firstname': items.firstname,
      'lastname': items.lastname,
      'startdate': items.startdate,
      'enddate': items.enddate,
      'comment': items.comment,
      'status': items.status,
      'empcodemanager': items.empcodemanager,
      'managername': items.managername,
      'createdate': DateTime.now()
    });
  }

  @override
  Future<void> deleteEmpleave(int _empcode, String _leavetype,
      DateTime _startdate, DateTime _enddate) async {
    CollectionReference _ref =
        await FirebaseFirestore.instance.collection('LEAVE');
    FirebaseFirestore.instance
        .collection('LEAVE')
        .where('empcode', isEqualTo: _empcode)
        .where('leavetype', isEqualTo: _leavetype)
        .where('startdate', isEqualTo: _startdate)
        .where('enddate', isEqualTo: _enddate)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _ref.doc(doc.id).delete();
      });
    });
  }

  @override
  Future<void> addDelegate(Delegate ss) {
    return _refdelegate.add({
      'empcode': ss.empcode,
      'leavetype': ss.leavetype,
      'empcodemanager': ss.empcodemanager,
      'managername': ss.managername,
      'startdate': ss.startdate,
      'enddate': ss.enddate,
      'empcodedelegate': ss.empcodedelegate,
      'delegatename': ss.delegatename,
      'createdate': DateTime.now()
    });
  }
@override
  Future<Delegate> checkEmpDelegate(String empcode, String leavetype,
                                              DateTime fromDate,DateTime toDate) async {
 QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('DELEGATE')
        .where('empcode', isEqualTo: int.parse(empcode))
       .where('leavetype', isEqualTo: leavetype)
        .where('startdate', isEqualTo: fromDate)
        .where('enddate', isEqualTo: toDate)
        .get();

    SingleDelegate delegates = SingleDelegate.fromJson(snapshot);
    return delegates.delegate;
  }

  @override
  Future<Employee> getEmpDelegate(int Empdelegate) async {
    String a = "นาย";
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('EMPLOYEE')
        .where('title', isEqualTo: a)
        //.orderBy('bookingNumber', descending: false)
        .get();

    SingleEmpdelegate delegates = SingleEmpdelegate.fromJson(snapshot);
    return delegates.empdelegate;
  }

  @override
  Future<List<Delegate>> getEmpDelegateList(
      int empcode) async {
   
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('DELEGATE')
        .where('empcode', isEqualTo: empcode)
        // .where('startdate', isGreaterThanOrEqualTo: startDate)
        // .where('enddate', isLessThanOrEqualTo: toDate)
        .get();

    AlldelegateList empdelegates = AlldelegateList.fromSnapshot(snapshot);
    return empdelegates.delegatelist;
  }

  @override
  Future<List<Empleave>> getapprovedList(
      int _empcodemanager, String _status) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('LEAVE')
        //.where('empcodemanager', isEqualTo:_empcodemanager)
        .where('status', isEqualTo: 'sent')
        .get();

    AllEmpleaves empleaves = AllEmpleaves.fromSnapshot(snapshot);
    return empleaves.empleaves;
  }

  @override
  Future<List<Empleave>> getapprovedListAll(int _empcodemanager) async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('LEAVE')
        .where('empcodemanager', isEqualTo: 19646)
        //.where('status', isEqualTo: 'sent')
        .get();

    AllEmpleaves empleaves = AllEmpleaves.fromSnapshot(snapshot);
    return empleaves.empleaves;
  }

  @override
  Future<void> updateapproved(
      int _empcode,
      int _empcodemanager,
      String _leavetype,
      DateTime _startdate,
      DateTime _enddate,
      String _status) async {
    CollectionReference _ref =
        await FirebaseFirestore.instance.collection('LEAVE');
    FirebaseFirestore.instance
        .collection('LEAVE')
        //.where('empcode', isEqualTo:_empcode)
        .where('empcode', isEqualTo: 50872)
        // .where('empcodemanager', isEqualTo:_empcodemanager)
        .where('status', isEqualTo: 'sent')
        .where('leavetype', isEqualTo: _leavetype)
        .where('startdate', isEqualTo: _startdate)
        .where('enddate', isEqualTo: _enddate)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _ref
            .doc(doc.id)
            .update({'status': _status})
            .then((value) => print("Todos Updated"))
            .catchError((error) => print("Failed to update Todos : $error"));
      });
    });
  }

  @override
  Future<EmpAPIModel> getemp(int empcode) async {
    var url = "https://apitest.ghb.co.th/extimeservice/api/Approval";

    final user = await DBLHelper.getToken();
    Map jsonData = {
      "accessToken": user[0]['token'],
      //"refreshToken": user[0]['refreshToken'],
      "emp_code": empcode
    };
    var body = json.encode(jsonData);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);

    var data = EmpAPIModel.fromJson(
      json.decode(response.body),
    );

    return data;
  }
}
