import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/controller/attendance_controller.dart';
import 'package:first_app/controller/empleave_controller.dart';
import 'package:first_app/model/Empleave_provider.dart';
import 'package:first_app/model/attendance.dart';
import 'package:first_app/model/attendance_provider.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/pages/leave_page.dart';
import 'package:first_app/services/attendance_service.dart';
import 'package:first_app/services/empleave_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'profile_page.dart';

class Attendance_list extends StatefulWidget {
  var service = AttendanceServices();

  var controller;
  var authController;
  Attendance_list() {
    controller = AttendanceController(service);
  }

  @override
  _Attendance_listState createState() => _Attendance_listState();
}

class _Attendance_listState extends State<Attendance_list> {
  List<Attendance> _attendanceList = List.empty();
  bool isLoading = false;
  EmpleaveProvider _profile = EmpleaveProvider();
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    setState(() {});
    widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
    _getAttendanceList();
  }

  void _getAttendanceList() async {
    var attendanceList = await widget.controller.fecthAttendanceList();
    setState(() {
      _attendanceList = attendanceList;
      //     context.read<EmpleaveProvider>().empleaveList = empleaveList;
      // empleaveList = empleaveList;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: _attendanceList.isEmpty ? 1 : _attendanceList.length,
          itemBuilder: (context, index) {
            if (_attendanceList.isEmpty) {
              return Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 300),
                      child: Text('ไม่พบข้อมูลการรับรองเวลาปฏิบัติงาน')));
            }
            return Card(
              child: ListTile(
                onLongPress: () {},
                 leading: CircleAvatar(
                    backgroundColor: Color(0xFF21BFBD),
                radius: 30,
                child: FittedBox(
                  child: Text('${index+1}',
                    //\style: TextStyle(color: iGreenColor,fontSize: 20),
                  ),
                ),
              ),
                title: Text('วันที่รับรองเวลาปฏิบัติงาน ${_attendanceList[index].attendancein.day}''/${_attendanceList[index].attendancein.month}''/${_attendanceList[index].attendancein.year}'),
               // subtitle: Text('วันที่ลา ${_attendanceList[index].attendancein}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AttendanceDetail(attendance: _attendanceList[index]),
                    ),
                  );
                },
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    //_getHistory();
    if (context.read<AttendanceProvider>().attendanceList != null) {
      _attendanceList = context.read<AttendanceProvider>().attendanceList!;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('ภาพรวมการรับรองเวลา',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )
              //color: iWhiteColor),
              ),
          //backgroundColor: iBlueColor,
          elevation: 0.0,
        ),
        body: Center(
          child: body,
        ));
  }
}
class AttendanceDetail extends StatefulWidget {
  final Attendance attendance;

  const AttendanceDetail({Key? key, required this.attendance}) : super(key: key);

  @override
  _AttendanceDetailState createState() => _AttendanceDetailState();
}

class _AttendanceDetailState extends State<AttendanceDetail> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดการรับรองเวลาปฏิบัติงาน',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
          //backgroundColor: iBlueColor,
          actions: [
            // IconButton(
            //   onPressed: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => LogInScreen()),
            //     // );
            //   },
            // icon: Icon(Icons.logout),
            // ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 10.0, ),
                    
                    Container(
                      //height: size.height * .10,
                      decoration: BoxDecoration(
                          //color: Colors.grey[200],
                          //border: Border.all(color: Colors.green,width: 3.0,),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0))),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: <Widget>[
                                  Text("วันที่เริ่มต้น",
                                      style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Text('${widget.attendance.attendancein.day}''/${widget.attendance.attendancein.month}''/${widget.attendance.attendancein.year}',
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ]),
                    ),
 Padding(
                        padding: const EdgeInsets.all(
                         15.0
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  // topRight: Radius.circular(60.0),
                                  // topLeft: Radius.circular(60.0),
                                  // bottomLeft: Radius.circular(36),
                                  // bottomRight: Radius.circular(36))
                                  )),
                          // color: Colors.cyan,
                          // child: Padding(
                          //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "เวลาเริ่มต้น ",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //     '${date.day}/${date.month}/${date.year}',
                                    //     textAlign: TextAlign.center,
                                    //     style: TextStyle(fontSize: 15, color: Colors.black),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                       Text('${widget.attendance.attendancein.hour}'':${widget.attendance.attendancein.second}',
                                      
        
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ]),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(
                         15.0
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  // topRight: Radius.circular(60.0),
                                  // topLeft: Radius.circular(60.0),
                                  // bottomLeft: Radius.circular(36),
                                  // bottomRight: Radius.circular(36))
                                  )),
                          // color: Colors.cyan,
                          // child: Padding(
                          //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "วันที่สิ้นสุด",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //     '${date.day}/${date.month}/${date.year}',
                                    //     textAlign: TextAlign.center,
                                    //     style: TextStyle(fontSize: 15, color: Colors.black),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                       Text('${widget.attendance.attendanceout.day}''/${widget.attendance.attendanceout.month}''/${widget.attendance.attendanceout.year}',
                                      
        
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ]),
                        )),
 Padding(
                                padding: const EdgeInsets.all(
                         15.0
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  // topRight: Radius.circular(60.0),
                                  // topLeft: Radius.circular(60.0),
                                  // bottomLeft: Radius.circular(36),
                                  // bottomRight: Radius.circular(36))
                                  )),
                          // color: Colors.cyan,
                          // child: Padding(
                          //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "เวลาสิ้นสุด ",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    // Padding(
                                    //   padding: EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //     '${date.day}/${date.month}/${date.year}',
                                    //     textAlign: TextAlign.center,
                                    //     style: TextStyle(fontSize: 15, color: Colors.black),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                       Text('${widget.attendance.attendanceout.hour}'':${widget.attendance.attendanceout.second}',
                                      
        
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ]),
                        )),    

                    Padding(
                         padding: const EdgeInsets.all(
                         15.0
                        
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              // color: Colors.grey[300],
                              borderRadius: BorderRadius.only(
                                  // topRight: Radius.circular(60.0),
                                  // topLeft: Radius.circular(60.0),
                                  // bottomLeft: Radius.circular(36),
                                  // bottomRight: Radius.circular(36))
                                  )),
                          // color: Colors.cyan,
                          // child: Padding(
                          //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text(
                                      "หมายเหตุ ",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                   
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '${widget.attendance.comment}',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ]),
                        )),
                                     SizedBox(height: 30),
                   
                         SizedBox(height: 30),
                  
                ]))));
  }
}
                          
                      