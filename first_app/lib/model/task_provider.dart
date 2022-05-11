
import 'package:first_app/model/task.dart';
import 'package:first_app/pages/utils.dart';
import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
 


  
  final List<Task> _events = [];
  List<Task> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  void setDate(DateTime date) => _selectedDate = date;

  List<Task> get eventsOfSelectedDate => _events.where(
        (event) {
          final selected = Utils.removeTime(_selectedDate);
          final from = Utils.removeTime(event.from);
          final to = Utils.removeTime(event.to);

          return from.isAtSameMomentAs(selectedDate) ||
              to.isAtSameMomentAs(selectedDate) 
             || (selected.isAfter(from) && selected.isBefore(to));
        },
      ).toList();

  void addEvent (Task event){
    _events.add(event);
    notifyListeners();
    
  }
   void deleteEvent(Task event) {
    _events.remove(event);

    notifyListeners();
  }

  void editEvent(Task newEvent, Task oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;

    notifyListeners();
  }
  
  
List<TaskItem>? _taskList;
  get taskList => this._taskList;

  set settaskList(value) {
    this._taskList = value;
    notifyListeners();
  }

get getempcode => this.empcode;

  set setempcode(empcode) {
    this.empcode = empcode;
    notifyListeners();
  }

  get gettitle => this.title;

  set settitle(title) {
    this.title = title;
    notifyListeners();
  }

  get getdescription => this.description;

  set setdescription(description) {
    this.description = description;
    notifyListeners();
  }

  get getfrom => this.from;

  set setfrom(from) {
    this.from = from;
    notifyListeners();
  }

  get getto => this.to;

  set setto(to) {
    this.to = to;
    notifyListeners();
  }
  //  get getbackgroundColor => this.backgroundColor;

  // set setbackgroundColor(backgroundColor) {
  //   this.backgroundColor = backgroundColor;
  //   notifyListeners();
  // }

   get getisAllDay => this.isAllDay;

  set setisAllDay(isAllDay) {
    this.isAllDay = isAllDay;
    notifyListeners();
  }
 int? empcode;
  String? title;
  String? description;
  DateTime? from;
  DateTime? to;
  // Color? backgroundColor;
  bool? isAllDay;



}

class TaskItem {
  final int empcode;
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  // final Color backgroundColor;
  final bool isAllDay;


  const TaskItem({
    Key? key,
    required this.empcode,
    required this.title,
    required this.description,
    required this.from,
    required this.to,
    // required this.backgroundColor,
     required this.isAllDay,

  });

  add(Map<String, String> map) {}
}


  int? empcode;
  String? leavetype;
  int? empcodemanager;
  String? managername;
  DateTime? startdate;
  DateTime? enddate;
  int? empcodedelegate;
  String? delegatename;
  DateTime? createdate;
