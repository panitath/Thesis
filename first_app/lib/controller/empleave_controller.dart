import 'dart:async';
import 'package:first_app/model/delegate.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/employee.dart';
import 'package:first_app/services/empleave_services.dart';

class EmpleaveController {
  final Services services;
  List<Empleave> empleaves = List.empty();
  List<Empleave> empleaveList = List.empty();
  Employee? empdelegate;

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





  void dispose() {
    onSyncHosBookingController.close();
    _isDisposed = true;
  }
}
