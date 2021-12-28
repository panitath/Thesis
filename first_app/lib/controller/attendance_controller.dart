import 'dart:async';
import 'package:first_app/model/attendance.dart';
import 'package:first_app/model/delegate.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/employee.dart';
import 'package:first_app/services/attendance_service.dart';

class AttendanceController {
  final Services services;
  List<Attendance> attendance = List.empty();
  List<Attendance> attendanceList = List.empty();
  

  StreamController<bool> onSyncController = StreamController<bool>.broadcast();
  Stream<bool> get onSync => onSyncController.stream;
  StreamController<bool> onSyncHosBookingController =
      StreamController<bool>.broadcast();
  Stream<bool> get onSyncHosBooking => onSyncHosBookingController.stream;
  bool _isDisposed = false;
  AttendanceController(this.services);

  
  void addAttendance(Attendance items) async {
    services.addAttendance(items);
  }

  Future<List<Attendance>> fecthAttendanceList() async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    attendanceList = await services.getAttendanceList();
    onSyncController.add(false);
    dispose();
    return attendanceList;
  }


Future<void> approveAttendance(
     int _empcode,int _empcodemanager,String _leavetype,
  DateTime _startdate, DateTime _enddate,String _status) async {
    await services.updateapprovedAttendance(_empcode,_empcodemanager,_leavetype, _startdate, _enddate, _status);
  }



  void dispose() {
    onSyncHosBookingController.close();
    _isDisposed = true;
  }
}
