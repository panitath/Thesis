
import 'package:first_app/controller/task_controller.dart';
import 'package:first_app/model/event.dart';
import 'package:first_app/model/task.dart';
import 'package:first_app/model/event_form_model.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/pages/calendar_page.dart';
import 'package:first_app/pages/event_editing_page.dart';
import 'package:first_app/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

class EventViewingPage extends StatefulWidget {
  final Task event;
  const EventViewingPage({
    Key? key,
    required this.event,
  
  }) : super (key: key);

  @override
  _EventViewingPageState createState() => _EventViewingPageState();
}

class _EventViewingPageState extends State<EventViewingPage> {
   var controller;

  var service = TaskService();

  _EventViewingPageState() {
    controller = TaskController(service);
  }

  @override
  Widget build(BuildContext context) 
  
{
  
  return Scaffold(
    
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildViewingActions(context, widget.event),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
           
        
            Text(
              widget.event.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              widget.event.description,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
  //  SizedBox(height: 32),
 buildDateTime(widget.event),

          ],
        ),
      );}

  Widget buildDateTime(Task event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'วันที่เริ่มต้น', event.from),
        if (!event.isAllDay) buildDate('วันที่สิ้นสุด', event.to),
      ],
    );
  }

  Widget buildDate(String title, DateTime date) {
    final styleTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
    final styleDate = TextStyle(fontSize: 18);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(child: Text(title, style: styleTitle)),
          Text(Utils.toDateTime(date), style: styleDate),
        ],
      ),
    );
  }

  List<Widget> buildViewingActions(BuildContext context, Task event) => [
        IconButton(
          icon: Icon(Icons.edit), // editttttttt
          onPressed: () => 
          
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => EventEditingPage(event: event),
            ),
          ),
        ),
       IconButton(
          icon: Icon(Icons.delete),  // deleteeeee
          onPressed: () {
             showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text('ยืนยัน'),
                                      content: Text('ยืนยันการลบ'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('ไม่ใช่')),
                                        TextButton(
                                          child: Text('ใช่'),
                                          onPressed: ()   async {{
            

              int? empcode = context.read<UserProfileProvider>().empcode;
          var services = TaskService();
                            TaskController(services)
                                .deleteTask(
                                     empcode!,
                                       widget.event.title,
                                       widget.event.description,
                                    widget.event.to,
                                    widget.event.from);
          Navigator.pop(context);
      await 
      
      Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => Calendar(),
  ),

      );
      
      }
         
         
          }
          
          
          
          ,)]);});
         // Navigator.pop(context);  
          }
          
          
          
          
          )
      ];
}



