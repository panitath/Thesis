import 'package:first_app/Screen/Thesis/event_edit_page.dart';
import 'package:first_app/widget/calendar_widget.dart';
import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendar'),
      ),body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.white,),backgroundColor: Colors.blue,
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventEditPage())),
      ),
      
    );
  }
}