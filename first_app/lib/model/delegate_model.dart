import 'package:cloud_firestore/cloud_firestore.dart';

class Delegate {
  int empcode;
  String leavetype;
  int empcodemanager;
  String managername;
  DateTime startdate;
  DateTime enddate;
  int empcodedelegate;
  String delegatename;
  DateTime createdate;
  Delegate(
      this.empcode,
      this.leavetype,
      this.empcodemanager,
      this.managername,
      this.startdate,
      this.enddate,
      this.empcodedelegate,
      this.delegatename,
      this.createdate);

  factory Delegate.fromDs(
    Map<String, Object?> json,
  ) {
    return Delegate(
      json['empcode'] as int,
      json['leavetype'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['startdate'] as DateTime,
      json['enddate'] as DateTime,
      json['empcodedelegate'] as int,
      json['delegatename'] as String,
      json['createdate'] as DateTime,
    );
  }

  factory Delegate.fromJson(
    Map<String, dynamic> json,
  ) {
    return Delegate(
      json['empcode'] as int,
      json['leavetype'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['startdate']!.toDate() as DateTime,
      json['enddate']!.toDate() as DateTime,
      json['empcodedelegate'] as int,
      json['delegatename'] as String,
      json['createdate']!.toDate() as DateTime,
    );
  }
}

class AllDelegate {
  final List<Delegate> delegate;
  AllDelegate(this.delegate);

  factory AllDelegate.fromSnapshot(QuerySnapshot s) {
    List<Delegate> delegate = s.docs.map((DocumentSnapshot ds) {
      return Delegate.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllDelegate(delegate);
  }
}

class SingleDelegate {
  final Delegate delegate;
  SingleDelegate(this.delegate);

  factory SingleDelegate.fromJson(QuerySnapshot s) {
    var delegate = s.docs.map((DocumentSnapshot ds) {
      return Delegate.fromJson(ds.data() as Map<String, dynamic>);
    });
    return SingleDelegate(delegate.first);
  }
}

class DelegateList {
   int empcode;
  String leavetype;
  int empcodemanager;
  String managername;
  DateTime startdate;
  DateTime enddate;
  int empcodedelegate;
  String delegatename;
  DateTime createdate;

 DelegateList(
      this.empcode,
      this.leavetype,
      this.empcodemanager,
      this.managername,
      this.startdate,
      this.enddate,
      this.empcodedelegate,
      this.delegatename,
      this.createdate);
      
      factory DelegateList.fromDs(
    Map<String, Object?> json,
  ) {
    return DelegateList(
json['empcode'] as int,
      json['leavetype'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['startdate'] as DateTime,
      json['enddate'] as DateTime,
      json['empcodedelegate'] as int,
      json['delegatename'] as String,
      json['createdate'] as DateTime,
    );
  }



factory DelegateList.fromJson(
    Map<String, dynamic> json,
  ) {
    return DelegateList(
      json['empcode'] as int,
      json['leavetype'] as String,
      json['empcodemanager'] as int,
      json['managername'] as String,
      json['startdate']!.toDate() as DateTime,
      json['enddate']!.toDate() as DateTime,
      json['empcodedelegate'] as int,
      json['delegatename'] as String,
      json['createdate']!.toDate() as DateTime,
    );
  }
}

class AlldelegateList {
  final List<Delegate> delegatelist;
  AlldelegateList(this.delegatelist);

  factory AlldelegateList.fromSnapshot(QuerySnapshot s) {
  
    List<Delegate> delegatelist = s.docs.map((DocumentSnapshot ds) {
      return Delegate.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    return AlldelegateList(delegatelist);
  }
}


