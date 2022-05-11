import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/attendance.dart';
import 'package:first_app/model/delegate_model.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/employee.dart';


abstract class Services {
  Future<List<Attendance>> getAttendance();
  Future<List<Attendance>> getAttendanceList();
  Future<void> addAttendance(Attendance items);
  // Future<List<Attendance>> getapprovedList(int _empcodemanager,String _status);
  //  Future<List<Attendance>> getapprovedListAll(int _empcodemanager);
  Future<void> updateapprovedAttendance(int _empcode,int _empcodemanager,String _leavetype,
  DateTime _startdate, DateTime _enddate ,String _status);

}

class AttendanceServices extends Services {
   CollectionReference _ref = FirebaseFirestore.instance.collection('ATTENDANCE');
  @override
  Future<List<Attendance>> getAttendance() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('ATTENDANCE').get();

    AllAttendance attendance = AllAttendance.fromSnapshot(snapshot);
    return attendance.attendance;
  }

   @override
  Future<List<Attendance>> getAttendanceList() async {
    QuerySnapshot snapshot =await FirebaseFirestore.instance.collection('ATTENDANCE').get();
    AllAttendanceList attendance = AllAttendanceList.fromSnapshot(snapshot);
    return attendance.attendancelist;
  }

  @override
  Future<void> addAttendance(Attendance items) {
    return _ref.add({
      
      'empcode': items.empcode,
      'title': items.title,
      'empfullname': items.empfullname,
      'empemail': items.empemail,
      'empcodemanager': items.empcodemanager,
      'managername': items.managername,
      'comment': items.comment,
      'status': items.status,
      'attendancein': items.attendancein,
      'attendanceout': items.attendanceout,
      'createdate':DateTime.now()


      
    });

  }



   @override
  Future<void> updateapprovedAttendance(int _empcode,int _empcodemanager,String _leavetype,
  DateTime _startdate, DateTime _enddate,String _status) async {
    CollectionReference _ref = await FirebaseFirestore.instance.collection('LEAVE');
    FirebaseFirestore.instance
        .collection('LEAVE')
          //.where('empcode', isEqualTo:_empcode)
          .where('empcode', isEqualTo:50872)
          // .where('empcodemanager', isEqualTo:_empcodemanager)
          .where('status', isEqualTo: 'sent')
          .where('leavetype', isEqualTo:_leavetype)
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

 
}
