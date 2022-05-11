import 'dart:async';
import 'package:first_app/model/task.dart';
import 'package:first_app/services/task_services.dart';

class TaskController {
  final TaskServices services;
  List<Task> events = List.empty();
  List<Task> eventList = List.empty();
 
  StreamController<bool> onSyncController = StreamController<bool>.broadcast();
  Stream<bool> get onSync => onSyncController.stream;
  StreamController<bool> onSyncHosBookingController =
  StreamController<bool>.broadcast();
  Stream<bool> get onSyncHosBooking => onSyncHosBookingController.stream;
  bool _isDisposed = false;
 TaskController(this.services);

  Future<List<Task>> fectgetTask() async {
    onSyncController.add(true);
    events = await services.getTask();
    onSyncController.add(false); // ดึงข้อมูลเสร็จแล้ว
    return events;
  }


  void addTask(Task items) async {
    services.addTask(items);
  }

  Future<List<Task>> fecthTaskList(int empcode,DateTime start,DateTime to) async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    eventList = await services.getTaskList(empcode, start, to);
    onSyncController.add(false);
    dispose();
    return eventList;
  }
Future<List<Task>> fecthTaskReportList(int empcode) async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    eventList = await services.getTaskReportList(empcode);
    onSyncController.add(false);
    dispose();
    return eventList;
  }
  
  Future<List<Task>> fecthTaskCalendarList() async {
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    eventList = await services.getTaskCalendarList();
    onSyncController.add(false);
    dispose();
    return eventList;
  }

  Future<void> deleteTask(
      int _empcode, String _title, String _description,
      DateTime _from, DateTime _to) async {
    await services.deleteTask(_empcode, _title,_description, _from,_to);
  }

 Future<void> updateTask(
      int _empcode, String _title, String _description,
      DateTime _from, DateTime _to) async {
    await services.updateTask(_empcode, _title,_description, _from,_to);
  }


  void dispose() {
    onSyncHosBookingController.close();
    _isDisposed = true;
  }
}
