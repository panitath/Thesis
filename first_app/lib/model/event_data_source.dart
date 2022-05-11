

import 'package:first_app/model/event.dart';
import 'package:first_app/model/task.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class  EventDataSource extends CalendarDataSource {
  EventDataSource(List<Task> appointments){
    this.appointments = appointments;
    
  }
  Task getEvent (int index) => appointments![index] as Task;
  
  @override
  DateTime getStartTime(int index) => getEvent(index).from;

    @override
  DateTime getEndTime(int index) => getEvent(index).to;

    @override
  String getSubject(int index) => getEvent(index).title;

   @override
  String getDescrition(int index) => getEvent(index).description;

  // @override
  // Color getColor(int index) => getEvent(index).backgroundColor;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;




  
}