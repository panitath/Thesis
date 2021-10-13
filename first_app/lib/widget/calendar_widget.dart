import 'package:first_app/model/event_data_source.dart';
import 'package:first_app/model/event_form_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'tasks_widget.dart';



class CalendarWidget extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
     final events = Provider.of<EventFormModel>(context).events;
          
   return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onSelectionChanged: (details) {
        final provider = Provider.of<EventFormModel>(context, listen: false);

        provider.setDate(details.date!);
      },
      onTap: (details) {
        final provider = Provider.of<EventFormModel>(context, listen: false);

        if (provider.selectedDate == details.date) {
          showModalBottomSheet(
            context: context,
            builder: (context) => TasksWidget(),
          );
        }
      },
      onLongPress: (details) {
        final provider = Provider.of<EventFormModel>(context, listen: false);

        provider.setDate(details.date!);
        showModalBottomSheet(
          context: context,
          builder: (context) => TasksWidget(),
        );
      },
    );
  }
}