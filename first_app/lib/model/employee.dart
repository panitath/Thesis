import 'package:cloud_firestore/cloud_firestore.dart';

class Employee {
  int empcode;
  String title;
  String fullname;
  String email;
  

  Employee(
      this.empcode,
      this.title,
      this.fullname,
      this.email);
    
  factory Employee.fromDs(
    Map<String, Object?> json,
  ) {
    return Employee(
      json['empcode'] as int,
      json['title'] as String,
      json['fullname'] as String,
      json['email'] as String,
    );
  }



  factory Employee.fromJson(
    Map<String, dynamic> json,
  ) {
    return Employee(
      json['empcode'] as int,
      json['title'] as String,
      json['fullname'] as String,
      json['email'] as String,
    );
  }
}

// class AllEmpleaves {
//   final List<Empleave> empleaves;
//   AllEmpleaves(this.empleaves);

//   factory AllEmpleaves.fromSnapshot(QuerySnapshot s) {
//     List<Empleave> empleaves = s.docs.map((DocumentSnapshot ds) {
//       return Empleave.fromJson(ds.data() as Map<String, dynamic>);
//     }).toList();
//     return AllEmpleaves(empleaves);
//   }
// }

class SingleEmpdelegate {
  final Employee empdelegate;
  SingleEmpdelegate(this.empdelegate);

  factory SingleEmpdelegate.fromJson(QuerySnapshot s) {
    var empdelegate = s.docs.map((DocumentSnapshot ds) {
      return Employee.fromJson(ds.data() as Map<String, dynamic>);
    });
    return SingleEmpdelegate(empdelegate.first);
  }
}

// class EmpleaveList {
//   int empcode;
//   String leavetype;
//   DateTime startdate;
//   DateTime enddate;
//   String comment;
//   String status;
//   int empcodemanager;
//   String managername;

//   DateTime createdate;

//   EmpleaveList(
//       this.empcode,
//       this.leavetype,
//       this.startdate,
//       this.enddate,
//       this.comment,
//       this.status,
//       this.empcodemanager,
//       this.managername,
//       this.createdate);
//   factory EmpleaveList.fromDs(
//     Map<String, Object?> json,
//   ) {
//     return EmpleaveList(
//       json['empcode'] as int,
//       json['leavetype'] as String,
//       json['startdate'] as DateTime,
//       json['enddate'] as DateTime,
//       json['comment'] as String,
//       json['status'] as String,
//       json['empcodemanager'] as int,
//       json['managername'] as String,
//       json['createdate'] as DateTime,
//     );
//   }

//   factory EmpleaveList.fromJson(
//     Map<String, dynamic> json,
//   ) {
//     return EmpleaveList(
//       json['empcode'] as int,
//       json['leavetype'] as String,
//       json['startdate']!.toDate() as DateTime,
//       json['enddate']!.toDate() as DateTime,
//       json['comment'] as String,
//       json['status'] as String,
//       json['empcodemanager'] as int,
//       json['managername'] as String,
//       json['createdate']!.toDate() as DateTime,
//     );
//   }
// }

// class AllEmpleaveList {
//   final List<Empleave> leavelist;
//   AllEmpleaveList(this.leavelist);

//   factory AllEmpleaveList.fromSnapshot(QuerySnapshot s) {
//     print('model');
//     List<Empleave> leavelists = s.docs.map((DocumentSnapshot ds) {
//       return Empleave.fromJson(ds.data() as Map<String, dynamic>);
//     }).toList();
//     print('return');
//     return AllEmpleaveList(leavelists);
//   }
// }
