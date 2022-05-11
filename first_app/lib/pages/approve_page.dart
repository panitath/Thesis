import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/constants/color_constant.dart';
import 'package:first_app/controller/authen_controller.dart';
import 'package:first_app/controller/empleave_controller.dart';
import 'package:first_app/model/Empleave_provider.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/leave_postapi_model.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/services/empleave_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'profile_page.dart';
import 'profilem_page.dart';

class Approve extends StatefulWidget {
  var service = EmpleaveServices();
  var authservice = EAuthenServices();
  var controller;
  var authController;
  Approve() {
    controller = EmpleaveController(service);
    authController = EAuthenController(authservice);
  }

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
  String startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String enddate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  List<Empleave> _approvedList = List.empty();
  bool isLoading = false;
  EmpleaveProvider _profile = EmpleaveProvider();
  final auth = FirebaseAuth.instance;
  int? empcodemanager = 19646;
  String? status = 'SENT';
  LeavePostAPIModel? model;

  @override
  void initState() {
    super.initState();
    setState(() {});
    widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
    _getApprovedList();
  }

  void _getApprovedList() async {
    var approvedList =
        await widget.controller.fectApprovedList(empcodemanager, status);
    setState(() {
      _approvedList = approvedList;
      //     context.read<EmpleaveProvider>().empleaveList = empleaveList;
      // empleaveList = empleaveList;
    });
  }



  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: _approvedList.isEmpty ? 1 : _approvedList.length,
          itemBuilder: (context, index) {
            if (_approvedList.isEmpty) {
              return Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 300),
                      child: Text('ไม่พบข้อมูลการลา')));
            }
            return Card(
              child: ListTile(
                onLongPress: () {},
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF21BFBD),
                  radius: 30,
                  child: FittedBox(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),
                    ),
                  ),
                ),
                title: Text('${_approvedList[index].leavetype}'),
                subtitle: Text('วันที่ลา ${_approvedList[index].startdate.day}''/${_approvedList[index].startdate.month}''/${_approvedList[index].startdate.year}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EmpleaveDetail(Empleaves: _approvedList[index]),
                    ),
                  );
                },
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    if (context.read<EmpleaveProvider>().empleaveList != null) {
      _approvedList = context.read<EmpleaveProvider>().empleaveList!;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('รายการรอการอนุมัติ',
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

class EmpleaveDetail extends StatefulWidget {
  final Empleave Empleaves;

  const EmpleaveDetail({Key? key, required this.Empleaves}) : super(key: key);

  @override
  _EmpleaveDetailState createState() => _EmpleaveDetailState();
}

class _EmpleaveDetailState extends State<EmpleaveDetail> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดการลา' ,style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,)),
          //backgroundColor: iBlueColor,
          automaticallyImplyLeading: false,
               actions: [
            IconButton(
              icon: Icon(Icons.home),color: Colors.white,
              iconSize: 28.0,
               onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile())
                );
              },
            ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: Column(children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 10.0, ),
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
                                      "ชื่อ สกุล ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
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
                                    Text(
                                      'น.ส ปณิตา  ธาราภูมิ',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black,fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ]),
                        )),
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
                                Text("ประเภทลา",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text('${widget.Empleaves.leavetype}',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ]),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(15.0),
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
                                      "วันที่เริ่มต้นการลา ",
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
                                    Text(
                                      '${widget.Empleaves.startdate.day}''/${widget.Empleaves.startdate.month}''/${widget.Empleaves.startdate.year}',
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
                                      "เวลาเริ่มต้นการลา ",
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
                                    Text(
                                      '${widget.Empleaves.startdate.hour}'':${widget.Empleaves.startdate.minute} น.',
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
                                      "วันสิ้นสุดการลา ",
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
                                    Text(
                                      '${widget.Empleaves.enddate.day}''/${widget.Empleaves.enddate.month}''/${widget.Empleaves.enddate.year}',
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
                                      "เวลาสิ้นสุดการลา ",
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
                                    Text(
                                      '${widget.Empleaves.enddate.hour}'':${widget.Empleaves.enddate.minute} น.',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ]),
                        )),

                  Padding(
                      padding: const EdgeInsets.all(15.0),
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
                                  Text(
                                     '${widget.Empleaves.comment}'== 'null' ? "": '${widget.Empleaves.comment}',
                                      style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              ),
                            ]),
                      )),SizedBox(height: 20),
                  Container(
                      // margin: EdgeInsets.only(top: 280),
                       width: 300,
                    height: 50,
                      child: ElevatedButton(

                          child: Text(
                            'อนุมัติ',
                            style: TextStyle(fontSize: 18),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text('ยืนยัน'),
                                    content: Text(
                                        'ยืนยันการอนุมัติการลา'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('ไม่ใช่')),
                                      TextButton(
                                          child: Text('ใช่'),
                                          onPressed: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              formKey.currentState!.save();
                                            }
                                            var services = EmpleaveServices();
                                            var controllers =
                                                EmpleaveController(services)
                                                    .approveEmpleave(
                                                        widget
                                                            .Empleaves.empcode,
                                                        19646,
                                                        widget.Empleaves
                                                            .leavetype,
                                                        widget.Empleaves
                                                            .startdate,
                                                        widget
                                                            .Empleaves.enddate,
                                                        'approved');

                                                         var authservice = EAuthenServices();

                                                         var authcontroller =
                                                EAuthenController(authservice)
                                                    .postleave(
                                                        widget
                                                            .Empleaves.empcode,widget.Empleaves.firstname ,widget.Empleaves.lastname,
                                                       widget.Empleaves.leaveid,
                                                       // widget.Empleaves.leavetype,
                                                        widget.Empleaves
                                                            .startdate,
                                                        widget
                                                            .Empleaves.enddate,
                                                        );

        
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        profile()));
                                          })
                                    ]);
                              },
                            );
                          } , style: ElevatedButton.styleFrom(
                            
                    primary: iGreenColor,
                    enabledMouseCursor: MouseCursor.uncontrolled,
                    shape: new RoundedRectangleBorder(
                     borderRadius: new BorderRadius.circular(8.0),
                    ),)),  ),
                    
                    SizedBox(height: 20),
                  Container(
                      // margin: EdgeInsets.only(top: 280),
                       width: 300,
                    height: 50,
                      child: ElevatedButton(
                          // BorderRadius: new BorderRadius.circular(30.0),
                          child: Text(
                            'ปฏิเสธ',style: TextStyle(fontSize: 18)
                            //style: TextStyle(fontSize: 20, color: iWhiteColor)),
                          ),
                          //height: 60,
                          // color: iBlueColor,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text('ยืนยัน'),
                                    content: Text(
                                        'ยืนยันการปฏิเสธการลา'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('ไม่ใช่')),
                                      TextButton(
                                        child: Text('ใช่'),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                          }
                                          var services = EmpleaveServices();
                                         EmpleaveController(services)
                                                    .approveEmpleave(
                                                        widget
                                                            .Empleaves.empcode,
                                                        19646,
                                                        widget.Empleaves
                                                            .leavetype,
                                                        widget.Empleaves
                                                            .startdate,
                                                        widget
                                                            .Empleaves.enddate,
                                                        'reject');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      profile()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                         // primary: iRedColor,
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      )
                                    ]);
                              },
                            );
                          }, style: ElevatedButton.styleFrom(
                                         primary: iRedColor,
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),))))
                ]))));
  }
}
           
