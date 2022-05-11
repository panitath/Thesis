import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/task.dart';

abstract class TaskServices {
  Future<List<Task>> getTask();
  Future<List<Task>> getTaskList(int _empcode,DateTime _start,DateTime _to);
   Future<List<Task>> getTaskReportList(int _empcode);
  Future<List<Task>> getTaskCalendarList();
  Future<void> addTask(Task items);
  Future<void> deleteTask(int _empcode, String _title, String _description,
      DateTime _from, DateTime _to);
  Future<void> updateTask(int _empcode, String _title, String _description,
      DateTime _from, DateTime _to);
}

class TaskService extends TaskServices {
  CollectionReference _ref = FirebaseFirestore.instance.collection('TASK');
  @override
  Future<List<Task>> getTask() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('TASK').get();

    AllTask tasks = AllTask.fromSnapshot(snapshot);
    return tasks.tasks;
  }

  @override
  Future<List<Task>> getTaskList(int empcode,DateTime start,DateTime to) async {
      DateTime startDate = DateTime.utc(start.year, start.month, start.day-1,12,00,00 );
         DateTime toDate = DateTime.utc(to.year, to.month, to.day );
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('TASK')
          .where('empcode', isEqualTo: empcode)
      .where('from',  isGreaterThanOrEqualTo:  startDate)
    //  .where('to', isLessThanOrEqualTo: toDate).
     .get();
    AllTaskList tasks = AllTaskList.fromSnapshot(snapshot);
    return tasks.tasklist;
  }
@override
  Future<List<Task>> getTaskReportList(int empcode) async {
      // DateTime startDate = DateTime.utc(start.year, start.month, start.day-1,12,00,00 );
      //    DateTime toDate = DateTime.utc(to.year, to.month, to.day );
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('TASK')
          .where('empcode', isEqualTo: empcode)
  //    .where('from',  isGreaterThanOrEqualTo:  startDate)
    //  .where('to', isLessThanOrEqualTo: toDate).
     .get();
    AllTaskList tasks = AllTaskList.fromSnapshot(snapshot);
    return tasks.tasklist;
  }







 @override
  Future<List<Task>> getTaskCalendarList() async {
    // DateTime startDate = DateTime.utc(from.year, from.month, from.day );
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('TASK')
           .where('empcode', isEqualTo: 50872)
      // .where('from',  isGreaterThanOrEqualTo:  startDate)
    //  .where('to', isLessThanOrEqualTo: toDate).
     .get();
    AllTaskList tasks = AllTaskList.fromSnapshot(snapshot);
    return tasks.tasklist;
  }
  @override
  Future<void> addTask(Task items) {
    return _ref.add({
      'empcode': items.empcode,
      'title': items.title,
      'description': items.description,
      'from': items.from,
      'to': items.to,
      'isAllDay': items.isAllDay
      // 'backgroundColor': 's',
    });
  }

  @override
  Future<void> deleteTask(int _empcode, String _title, String _description,
      DateTime _from, DateTime _to) async {
    CollectionReference _ref =
        await FirebaseFirestore.instance.collection('TASK');
    FirebaseFirestore.instance
        .collection('TASK')
        .where('empcode', isEqualTo: _empcode)
        .where('title', isEqualTo: _title)
        .where('description', isEqualTo: _description)
        
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _ref.doc(doc.id).delete();
      });
    });
  }

  @override
  Future<void> updateTask(int _empcode, String _title, String _description,
      DateTime _from, DateTime _to) async {
    CollectionReference _ref =
        await FirebaseFirestore.instance.collection('TASK');
    FirebaseFirestore.instance
        .collection('TASK')
        //.where('empcode', isEqualTo:_empcode)
        .where('empcode', isEqualTo: _empcode)
        .where('from', isEqualTo: _from)
        //.where('description', isEqualTo: _description)
        // .where('startdate', isEqualTo: _from)
        // .where('enddate', isEqualTo: _to)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        _ref
            .doc(doc.id)
            .update({
              'title': _title,
              'description': _description,
              'from': _from,
              'to': _to
            })
            .then((value) => print("Todos Updated"))
            .catchError((error) => print("Failed to update Todos : $error"));
      });
    });
  }
}
