
import 'package:first_app/controller/task_controller.dart';
import 'package:first_app/model/event_data_source.dart';
import 'package:first_app/model/task.dart';
import 'package:first_app/model/task_provider.dart';
import 'package:first_app/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'tasks_widget.dart';

class CalendarWidget extends StatefulWidget {
  var service = TaskService();
  var controller;
  CalendarWidget() {
    controller = TaskController(service);
  }

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  List<Task> _emptaskList = List.empty();

  @override
  void initState() {
    super.initState();
    setState(() {});
    _getTaskList();
  }

  void _getTaskList() async {
    var eventList = await widget.controller.fectTaskList();
    setState(() {
      _emptaskList = eventList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final event = Provider.of<TaskProvider>(context).events;
  

     if (context.read<TaskProvider>().taskList != null) {
      _emptaskList = context.read<TaskProvider>().taskList!;
    }

    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(event),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onSelectionChanged: (details) {
        final provider = Provider.of<TaskProvider>(context, listen: false);

        provider.setDate(details.date!);
      },
      onTap: (details) {
        final provider = Provider.of<TaskProvider>(context, listen: false);

        if (provider.selectedDate == details.date) {
          showModalBottomSheet(
            context: context,
            builder: (context) => TasksWidget(),
          );
        }
      },
      onLongPress: (details) {
        final provider = Provider.of<TaskProvider>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => TasksWidget(),
        );
      },
    );
  }
}
