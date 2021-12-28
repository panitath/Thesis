// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:first_app/api/notification_api.dart';
import 'package:first_app/controller/attendance_controller.dart';
import 'package:first_app/controller/empleave_controller.dart';
import 'package:first_app/model/Empleave_provider.dart';
import 'package:first_app/model/attendance.dart';
import 'package:first_app/model/attendance_provider.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/even.dart';
import 'package:first_app/pages/approve_page.dart';
import 'package:first_app/pages/attendancelist_page.dart';
import 'package:first_app/pages/leavelist_page.dart';
import 'package:first_app/services/attendance_service.dart';
import 'package:first_app/services/empleave_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'utils.dart';

class attendance extends StatefulWidget {
  final Event? event;
  const attendance({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _attendanceState createState() => _attendanceState();
}

class _attendanceState extends State<attendance> {
 var service = AttendanceServices();
  var controller;
  _attendanceState() {
    controller = AttendanceController(service);
  }


  String startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String enddate = DateFormat('dd-MM-yyyy').format(DateTime.now());


  String? _filename;
  final formKey = GlobalKey<FormState>();
 
 // Empleave myleave = new Empleave(empcode, String leaveid, DateTime startdate, DateTime enddate, String comment);
  
  final leaveidController = TextEditingController();
  final startdateController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  bool isAllDay = false;
  String? comment;
  late int empcode;

  @override
  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    listenNotifications();

    fromDate = DateTime.now();
    toDate = DateTime.now();//.add(Duration(hours: 2));

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now();//.add(Duration(hours: 2));
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      isAllDay = event.isAllDay;
    }
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Approve() //(payload: payload),
          ));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return
        // Consumer<emp_leave>(
        //   builder: (context, emp_leave, child) =>

        Scaffold(
      appBar: AppBar(
          title: Text(
        "สร้างรับรองเวลาปฏิบัติงาน",
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
                //buildTitle(),
                SizedBox(height: 12),
                buildDateTimePickers(),
                SizedBox(height: 12),
                buildDescription(),
                buildAttachfile(),
                buildAttachfileName(),
                SizedBox(
                  width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text("ส่ง",style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          NotificationApi.showNotification(
                            title: 'Attendance Request',
                            body: 'น.ส.ปณิตา ธาราภูมิ ขออนุมัติการรับรองเวลา',
                            payload: 'sarah.abs',
                          );
                          
                       
                         
                        
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context.read<AttendanceProvider>().empcode =
                                50872;
                            context.read<AttendanceProvider>().title =
                                'นางสาว';
                            context.read<AttendanceProvider>().empfullname =
                                'ปณิตา ธาราภูมิ';
                            context.read<AttendanceProvider>().empemail =
                                'panita@ghb.co.th';
                                context.read<AttendanceProvider>().empcodemanager = 19646;
                                context.read<AttendanceProvider>().managername = 'Charunee';
                                context.read<AttendanceProvider>().comment = descriptionController.text;
                               

                            context.read<AttendanceProvider>().attendancein = fromDate;
                            context.read<AttendanceProvider>().attendanceout = toDate;
                            context.read<AttendanceProvider>().status = 'sent';
                            context.read<AttendanceProvider>().createdate = DateTime.now();
                             

                            List<AttendanceList> Listattendance = [];
                            if (context
                                    .read<AttendanceProvider>()
                                    .attendanceList!=
                                null) {
                              // Listempleave = context
                              //     .read<EmpleaveProvider>()
                              //   .empleaveList;
                            }
                             //add to State
                            Listattendance.add(AttendanceList(50872, 'นางสาว', 'ปณิตา ธาราภูมิ', 'panita@ghb.co.th',19646,'Charunee',descriptionController.text,'sent',fromDate, toDate,DateTime.now()));

                          //add to firebase
              controller.addAttendance(new Attendance(50872, 'นางสาว', 'ปณิตา ธาราภูมิ', 'panita@ghb.co.th',19646,'Charunee',descriptionController.text,'sent',fromDate, toDate,DateTime.now())
        );

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Attendance_list();
                            }));
                          }
                        }))
              ]))),
    );
  }

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _filename = 'ชื่อไฟล์ :' + file.name;
      });
    } else {
      // User canceled the picker
    }
  }


  // Widget buildTitle() =>
  //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
  //       Column(
  //         children: <Widget>[
  //           Text("ประเภทลา", style: TextStyle(fontSize: 18)),
  //         ],
  //       ),
  //       Column(
  //         children: <Widget>[
  //           DropdownButton<String>(
  //             value: leavetype,
  //             items: <String>[
  //               'ลากิจ',
  //               'ลาพักผ่อน',
  //               'ลาคลอด',
  //             ].map<DropdownMenuItem<String>>((String value) {
  //               return DropdownMenuItem<String>(
  //                 value: value,
  //                 child: Text(value),
  //               );
  //             }).toList(),
  //             onChanged: (String? newValue) {
  //               setState(() {
  //                 leavetype = newValue!;

  //                 // myleave.leaveid = leavetype;
  //               });
  //             },
  //           ),
  //         ],
  //       ),
  //     ]);

  Widget buildDescription() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'หมายเหตุ',
        ), 
               
        textInputAction: TextInputAction.newline,
        maxLines: 3,
        //\ onFieldSubmitted: (_) => saveForm(),
         onChanged: (String? comment) {
                                 // myleave.comment = comment;
                                },
        controller: descriptionController,
        
      );

  Widget buildAttachfile() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        Column(
          children: <Widget>[
            Text("เอกสารแนบ", style: TextStyle(fontSize: 18)),
          ],
        ),
        Column(
          children: <Widget>[
            Row(children: <Widget>[
              IconButton(
                icon: const Icon(Icons.attach_file),
                // Icon:Icons.attach_file,
                onPressed: selectFile,
              ),
            ])
          ],
        ),
      ]);
  Widget buildAttachfileName() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        Column(
          children: <Widget>[
            Text(
              "",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Row(children: <Widget>[
              Text(_filename == null ? '' : _filename.toString()),
            ])
          ],
        ),
      ]);

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),buildTo(),
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
            if (!isAllDay)
              Expanded(
                child: buildDropdownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () => pickFromDateTime(pickDate: false),
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
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
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
            Text(header, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState((){  toDate = date;
    enddate = toDate.toString();}
    );
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
  }
}
