import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Task{
  int empcode;
  String title;
  String description;
  DateTime from;
  DateTime to;
  // Color backgroundColor;
  bool isAllDay;

  Task(
  this.empcode,
  this.title,
  this.description,
  this.from,
  this.to,
  // this.backgroundColor,
  this.isAllDay);


  factory Task.fromDs(
    Map<String, Object?> json,
  ) {
    return Task(
      json['empcode'] as int,
      json['title'] as String,
      json['description'] as String,
      json['from'] as DateTime,
      json['to'] as DateTime,
    //  json['backgroundColor'] as Color,
      json['isAllDay'] as bool,
     
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json,
  ) {
    return Task(
      json['empcode'] as int,
      json['title'] as String,
      json['description'] as String,
      json['from']!.toDate() as DateTime,
      json['to']!.toDate() as DateTime,
      //  json['backgroundColor'] as Color,
      json['isAllDay'] as bool,
    );
  }
}

class AllTask {
  final List<Task> tasks;
  AllTask(this.tasks);

  factory AllTask.fromSnapshot(QuerySnapshot s) {
    List<Task> tasks = s.docs.map((DocumentSnapshot ds) {
      return Task.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllTask(tasks);
  }
}

class SinglTask {
  final Task task;
  SinglTask(this.task);

  factory SinglTask.fromJson(QuerySnapshot s) {
    var task = s.docs.map((DocumentSnapshot ds) {
      return Task.fromJson(ds.data() as Map<String, dynamic>);
    });
    return SinglTask(task.first);
  }
}

class TaskList {
  int empcode;
  String title;
  String description;
  DateTime from;
  DateTime to;
  // Color backgroundColor;
  bool isAllDay;

  TaskList(
  this.empcode,
  this.title,
  this.description,
  this.from,
  this.to,
//  this.backgroundColor,
  this.isAllDay);
  factory TaskList.fromDs(
    Map<String, Object?> json,
  ) {
    return TaskList(
      json['empcode'] as int,
      json['title'] as String,
      json['description'] as String,
      json['from'] as DateTime,
      json['to'] as DateTime,
      // json['backgroundColor'] as Color,
      json['isAllDay'] as bool,
    );
  }

  factory TaskList.fromJson(
    Map<String, dynamic> json,
  ) {
    return TaskList(
      json['empcode'] as int,
      json['title'] as String,
      json['description'] as String,
      json['from'] as DateTime,
      json['to'] as DateTime,
      // json['backgroundColor'] as Color,
      json['isAllDay'] as bool,
    );
  }
}

class AllTaskList {
  final List<Task> tasklist;
  AllTaskList(this.tasklist);

  factory AllTaskList.fromSnapshot(QuerySnapshot s) {
    print('model');
    List<Task> tasklist = s.docs.map((DocumentSnapshot ds) {
      return Task.fromJson(ds.data() as Map<String, dynamic>);
    }).toList();
    print('return');
    return AllTaskList(tasklist);
  }
}



