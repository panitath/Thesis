import 'dart:async';
import 'package:first_app/model/Empleave_provider.dart';
import 'package:first_app/model/delegate_model.dart';
import 'package:first_app/model/emp_api_model.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/employee.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/services/empleave_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class EmpleaveController {
  final Services services;
  List<Empleave> empleaves = List.empty();
  List<Empleave> empleaveList = List.empty();
  Employee? empdelegate;
  Delegate? empcheckdelegate;
   List<Delegate> delegate = List.empty();

  StreamController<bool> onSyncController = StreamController<bool>.broadcast();
  Stream<bool> get onSync => onSyncController.stream;
  StreamController<bool> onSyncHosBookingController =
  StreamController<bool>.broadcast();
  Stream<bool> get onSyncHosBooking => onSyncHosBookingController.stream;
  bool _isDisposed = false;
  EmpleaveController(this.services);

  Future<List<Empleave>> fectEmpleaves() async {
    onSyncController.add(true);
    empleaves = await services.getEmpleaves();
    onSyncController.add(false); // ดึงข้อมูลเสร็จแล้ว
    return empleaves;
  }

  Future<List<Empleave>> fectApprovedList(
      int _empcodemanager, String _status) async {
    onSyncController.add(true);
    //empleaves = await services.getapprovedList(_empcodemanager, _status);
    empleaves = await services.getapprovedList(19646,'SENT');
    onSyncController.add(false);
    return empleaves;
  }
  

   Future<List<Empleave>> fectApprovedListAll(
      int _empcodemanager) async {
    onSyncController.add(true);
    //empleaves = await services.getapprovedList(_empcodemanager, _status);
    empleaves = await services.getapprovedListAll(19646);
    onSyncController.add(false);
    return empleaves;
  }


  void addEmpLeave(Empleave items) async {
  //   final emp = await getemp(items.empcode.toString());
  //  items.empcodemanager = int.parse(emp.employee!.employee!.empcodemanager.toString()) ;
  // String managerfirstname = emp.employee!.employee!.firstnamemanager.toString(); 
  // String managerlastname = emp.employee!.employee!.lastnamemanager.toString();   
  //  items.managername = '${managerfirstname}'+ ' ' +'${managerlastname}';
    services.addEmpLeave(items);
      
    
  }

  Future<List<Empleave>> fecthEmpleaveList() async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    empleaveList = await services.getEmpleaveList();
    onSyncController.add(false);
    dispose();
    return empleaveList;
  }

  Future<void> deleteEmpleave(
      int _empcode,String _leavetype, DateTime _startdate, DateTime _enddate) async {
    await services.deleteEmpleave(_empcode, _leavetype,_startdate, _enddate);
  }

Future<void> approveEmpleave(
     int _empcode,int _empcodemanager,String _leavetype,
  DateTime _startdate, DateTime _enddate,String _status) async {
    await services.updateapproved(_empcode,_empcodemanager,_leavetype, _startdate, _enddate, _status);
  }

  /// Delegate

  void addDelegate(Delegate item) async {
    services.addDelegate(item);
  }

 Future<Employee?> fecthEmpDelegate(String empcodedelegate) async {
    print('con' + empcodedelegate.toString());
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    empdelegate = await services.getEmpDelegate(int.parse(empcodedelegate));
    onSyncController.add(false);
    dispose();
    return empdelegate;
  }

  Future<List<Delegate>> fecthEmpDelegateList(String empcodedelegate) async {
    
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    delegate = await services.getEmpDelegateList(int.parse(empcodedelegate));
    onSyncController.add(false);
    dispose();
    return delegate;
  }

  Future<EmpAPIModel> getemp(String empcode) async {
    onSyncController.add(true);
    var model = await services.getemp( int.parse(empcode));
    onSyncController.add(false);
    return model;
  }


   Future<Delegate?> CheckEmpDelegate(String empcodedelegate, String leavetype,
                                              DateTime fromDate,DateTime toDate) async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
      DateTime checkfromDate = new DateTime(fromDate.year, fromDate.month, fromDate.day);
    DateTime checktoDate = new DateTime(toDate.year, toDate.month, toDate.day);
    
    onSyncController.add(true);
    empcheckdelegate = await services.checkEmpDelegate(empcodedelegate,leavetype,checkfromDate,checktoDate);
    onSyncController.add(false);
    dispose();
    return empcheckdelegate;
  }





  void dispose() {
    onSyncHosBookingController.close();
    _isDisposed = true;

}
}