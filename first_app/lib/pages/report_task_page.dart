
import 'package:first_app/controller/task_controller.dart';
import 'package:first_app/model/event.dart';
import 'package:first_app/model/task.dart';
import 'package:first_app/model/task_provider.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/pages/utils.dart';
import 'package:first_app/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'profile_page.dart';
import 'profilem_page.dart';


class task_report extends StatefulWidget {
   final Event? event;
  const task_report({
    Key? key,
    this.event,
  }) : super(key: key);


  @override
 _task_reportState createState() => _task_reportState();
}

class _task_reportState extends State<task_report> {

 final formKey = GlobalKey<FormState>();
    late DateTime fromDate;
  late DateTime toDate;
   String startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String enddate = DateFormat('dd-MM-yyyy').format(DateTime.now());
@override
  void initState() {
    super.initState();
   
    fromDate = DateTime.now();
    toDate = DateTime.now();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now(); 
    } else {
      final event = widget.event!;

    
    }
  }
 @override
  Widget build(BuildContext context) {
    return
        Scaffold(
      appBar: AppBar(
          title: Text(
        "รายงานการทำงาน",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      )),
      //centerTitle: true,
      // leading: Icon(Icons.menu),

      body: Form(
          key: formKey,
          child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              
                SizedBox(height: 12),
                buildDateTimePickers(),
                SizedBox(height: 12),
            
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text("เรียกดู", style: TextStyle(fontSize: 18)),
                        onPressed: () {
                        
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          context.read<TaskProvider>().empcode = 50872;
                                           context.read<TaskProvider>().from = fromDate;
                                            context.read<TaskProvider>().to = toDate;
                                          
                                                       

                                          List<TaskList> Listtask = [];
                                          if (context
                                                  .read<TaskProvider>()
                                                  .taskList !=
                                              null) {
                                          
                                          }
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return TaskDetail();
                                          }));
                                     
                        }})),
              ]))), 
    );
  }

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),  buildTo(),
          // if (!isAllDay) buildTo(),
          // CheckboxListTile(
          //   controlAffinity: ListTileControlAffinity.leading,
          //   title: Text('All Day Event'),
          //   value: isAllDay,
          //   activeColor: Theme.of(context).primaryColor,
          //   onChanged: (value) => setState(() => isAllDay = value!),
          // )
        ],
      );

  Widget buildFrom() => buildHeader(
        header: 'วันที่เริ่มต้น',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
           
          ],
        ),
      );
      
  Widget buildTo() => buildHeader(
        header: 'วันที่สิ้นสุด',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
         
          ],
        ),
      );


  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(header,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            child,
          ],
        ),
      );

  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );

  
  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() {
      toDate = date;
      enddate = toDate.toString();
    });
  }
  Future pickFromDateTime({required bool pickDate}) async {
    final date = await pickDateTime(fromDate, pickDate: pickDate);
    if (date == null) return;

    if (date.isAfter(toDate)) {
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
    }
    setState(() {
      fromDate = date;
      startdate = fromDate.toString();
    });
  }

  
  
  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate ?? DateTime(2015, 8),
        lastDate: DateTime(2101),
      );

      if (date == null) return null;

      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);

      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (timeOfDay == null) return null;

      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);

      return date.add(time);
    }
  }}



class TaskDetail extends StatefulWidget {
  var service = TaskService();
  var controller;

  TaskDetail() {
    controller = TaskController(service);
  }

  
  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
    bool isLoading = false;
    List<Task> _emptaskList = List.empty();

    @override
  void initState() {
    super.initState();
    setState(() {});
    widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
    _getEmptaskList();
  }
  void _getEmptaskList() async {
   
       int? empcode = context.read<UserProfileProvider>().empcode;
   
    var emptaskList = await widget.controller.fecthTaskReportList(empcode);
    setState(() {
      _emptaskList = emptaskList;
     
    });
  }


  final formKey = GlobalKey<FormState>();
  @override
  Widget get body => isLoading
  
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: _emptaskList.isEmpty ? 1 : _emptaskList.length,
          itemBuilder: (context, index) {
            if (_emptaskList.isEmpty) {
              return Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 300),
                      child: Text('ไม่พบข้อมูลการทำงาน')));
            }
            return Card(
              child: ListTile(  tileColor: Colors.grey[100],
                onLongPress: () {},
                 leading: CircleAvatar(
                    backgroundColor: Color(0xFF21BFBD),
                radius: 30,
                child: FittedBox(
                  child: Text('${index+1}',
                    style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                  ),
                ),
              ),
                title: Text('${_emptaskList[index].title}'),
                //subtitle: Text('วันที่ลา ${_empclockList[index].startdate.day}/${_empleaveList[index].startdate.month}/${_empclockList[index].startdate.year}'),
               subtitle: Text('วันที่ ${_emptaskList[index].from.day}'+ '/${_emptaskList[index].from.month}'
               + '/${_emptaskList[index].from.year} เวลา '+ '${_emptaskList[index].from.hour}'+ ':${_emptaskList[index].from.minute} น.'),
              
              
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         EmpleaveDetail(Empleaves: _empclockList[index]),
                  //   ),
                  // );
                },
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    //_getHistory();
    if (context.read<TaskProvider>().taskList != null) {
      _emptaskList = context.read<TaskProvider>().taskList!;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('ภาพรวมการทำงาน',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )
              //color: iWhiteColor),
              ),
              automaticallyImplyLeading: false,
               actions: [
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              iconSize: 28.0,
               onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile())
                );
              },
            ),
          ],
          //backgroundColor: iBlueColor,
          elevation: 0.0,
        ),
        body: Center(
          child: body,
        ));
  }
}

