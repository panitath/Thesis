import 'package:first_app/controller/task_controller.dart';
import 'package:first_app/model/event_data_source.dart';
import 'package:first_app/model/task.dart';
import 'package:first_app/model/task_provider.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/pages/event_edit_page.dart';
import 'package:first_app/pages/profile_page.dart';
import 'package:first_app/services/task_services.dart';
import 'package:first_app/widget/calendar_widget.dart';
import 'package:first_app/widget/tasks_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class Calendar extends StatefulWidget {
  var service = TaskService();
  var controller;
  Calendar() {
    controller = TaskController(service);
  }

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<Task> _emptaskList = List.empty();
  bool isLoading = false;
final  color = const Color(0xFFFFAD33);

  @override
  void initState() {
    super.initState();
    setState(() {
      _getTaskList();
    });
    widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
  }
 
  void _getTaskList() async {
    int? empcode = context.read<UserProfileProvider>().empcode;
    var eventList = await widget.controller.fecthTaskCalendarList();
    setState(() {
      _emptaskList = eventList;
    });
  }

  Widget 
  
  get body => isLoading
      ? CircularProgressIndicator()
      : SfCalendar(
          view: CalendarView.month,
          dataSource: EventDataSource(_emptaskList),
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
            DateTime? _visibleDates = details.date;
            context.read<TaskProvider>().from = _visibleDates;
            // provider.setDate(details.date!);
            showModalBottomSheet(
              context: context,
              builder: (context) => TasksWidget(),
            );
          },
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ปฏิทิน',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            )),
     //   automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              color:color,
            ),
            onPressed: () {
            
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Calendar();
              }));
              // do something
            },
          ),
             IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            onPressed: () {
            
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return profile();
              }));
              // do something
            },
          )
        ],
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        onPressed: () => 
        
        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) => EventEditPage())),
       //Navigator.push(context, MaterialPageRoute(builder: (context) => EventEditPage())).then((_) => setState(() {}))
       Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => EventEditPage(),
  ),

      )
      ));
      
    
  }
}
