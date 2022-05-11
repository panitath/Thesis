import 'package:first_app/controller/task_controller.dart';
import 'package:first_app/model/event_data_source.dart';
import 'package:first_app/model/event_form_model.dart';
import 'package:first_app/model/task.dart';
import 'package:first_app/model/task_provider.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/pages/event_viewing_page.dart';
import 'package:first_app/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class TasksWidget extends StatefulWidget {
  var service = TaskService();
  var controller;
  TasksWidget() {
    controller = TaskController(service);
  }
 
  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

 DateTime? from ;
class _TasksWidgetState extends State<TasksWidget> {
List<Task> _emptaskList = List.empty();
   bool isLoading = false;
  

  @override
  void initState() {
    super.initState();
    setState(() {});
     widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
    
    _getTaskList();
  }
 

  void _getTaskList() async {
    var eventList = await widget.controller.fecthTaskList(empcode,from,from);
    setState(() {
      _emptaskList = eventList;
    });
  }





  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final selectedEvents = provider.eventsOfSelectedDate;
    empcode = context.read<UserProfileProvider>().empcode;
from = context.read<TaskProvider>().from; 
   
  //     if(selectedEvents.isEmpty){
  //       return Center(child: Text('No Event found!',
  //       style: TextStyle(color: Colors.black,fontSize: 24),
  //       ),
  //   );
  // }
return SfCalendarTheme(

  data:SfCalendarThemeData(
    timeTextStyle: TextStyle(fontSize: 16,color: Colors.black)
  ),
  child: SfCalendar(
    view: CalendarView.timelineDay,
    dataSource: EventDataSource(_emptaskList),
    initialDisplayDate: provider.selectedDate,
    appointmentBuilder: appointmentBuilder,
    headerHeight: 0,
    todayHighlightColor: Colors.black,
    selectionDecoration: BoxDecoration(color: Colors.transparent),
    onTap: (details){
      if(details.appointments == null) return ;
      final event = details.appointments!.first;
    //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EventViewingPage(event :event)));
 Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => EventViewingPage(event :event),
  ),
);
   
    },
  ),
  
);}

Widget appointmentBuilder(
  BuildContext context,
  CalendarAppointmentDetails details,

){
  final event = details.appointments.first;
  return Container(
    width: details.bounds.width,
    height: details.bounds.height,
    decoration: BoxDecoration(color: Colors.green,
    borderRadius: BorderRadius.circular(12)),
    child: Center(
      child: Text( event.title,
        maxLines : 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.bold),
      ),
    ),
  );
}

}