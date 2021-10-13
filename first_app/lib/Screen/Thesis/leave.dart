

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:first_app/Screen/Thesis/approve.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Screen/Thesis/leavelist.dart';
import 'package:first_app/api/notification_api.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/Empleavelist_form_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'second_page.dart';

class leave extends StatefulWidget {
  const leave({Key? key}) : super(key: key);

  @override
  _leaveState createState() => _leaveState();
}

class _leaveState extends State<leave> {
  List leavelist = ['ลากิจ', 'ลาพักผ่อน', 'ลาคลอด'];
  String leavetype = 'ลากิจ';
  String leaveid = "";

  String startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String enddate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  DateTime datestart = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  Future<Null> selectDatePickerstart(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: datestart,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030));
    if (datePicked != null && datePicked != datestart) {
      setState(() {
        datestart = datePicked;
        myleave.startdate = datestart;
      });
    }
  }

  DateTime dateend = DateTime.now();
  // TimeOfDay time = TimeOfDay.now();
  Future<Null> selectDatePickerend(BuildContext context) async {
    final DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: dateend,
        firstDate: DateTime(1940),
        lastDate: DateTime(2030));
    if (datePicked != null && datePicked != datestart) {
      setState(() {
        dateend = datePicked;
        myleave.enddate = dateend;
      });
    }
  }

  String? _filename;

  // Future<void> _openDatepickerstart(BuildContext context) async {
  //   final DateTime? d = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: new DateTime(2017),
  //       lastDate: new DateTime(2030));

  //   if (d != null) {
  //     setState(() {
  //       enddate = DateFormat('dd-MM-yyyy').format(d);
  //       myleave.enddate = d;
  //     });
  //   }
  // }

  void getDropDownItem() {
    setState(() {
      leaveid = leavetype;
      myleave.leaveid = leaveid;
    });
  }

  final formKey = GlobalKey<FormState>();
  Empleave myleave = Empleave();
  final leaveidController = TextEditingController();
  final startdateController = TextEditingController();
  String? _leaveid;
  DateTime? _startdate;
  DateTime? _enddate;
  String? _comment;

  // final Future<FirebaseApp> firebase =
  //     Firebase.initializeApp(); // เตรียม Firebase
  @override
  void initState() {
    super.initState();

    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Approve()//(payload: payload),
      ));

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: firebase,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Scaffold(
    //           appBar: AppBar(
    //             title: Text("Error"),
    //           ),
    //           body: Center(
    //             child: Text("${snapshot.error}"),
    //           ),
    //         );
    //       }

    // if (snapshot.connectionState == ConnectionState.done) {
    return
        // Consumer<emp_leave>(
        //   builder: (context, emp_leave, child) =>
        Scaffold(
            appBar: AppBar(
              title: Text("สร้างคำขอลาหยุด"),
              centerTitle: true,
              // leading: Icon(Icons.menu),
            ),
            body: Card(
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(
                        // decoration: BoxDecoration(
                        //     color: Colors.yellow[600],
                        //     borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 12.0, bottom: 12.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Text("ประเภทลา",
                                        style: TextStyle(fontSize: 20)),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    DropdownButton<String>(
                                      value: leavetype,
                                      items: <String>[
                                        'ลากิจ',
                                        'ลาพักผ่อน',
                                        'ลาคลอด',
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          leavetype = newValue!;

                                          // myleave.leaveid = leavetype;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      Container(
                          // color: Colors.cyan,
                          child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "วันที่เริ่มต้นการลา",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
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
                                  Row(children: <Widget>[
                                    Text(
                                        '${datestart.day}/${datestart.month}/${datestart.year}'),
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),

                                      onPressed: () {
                                        selectDatePickerstart(context);
                                      },
                                      //color: iBlueColor,
                                    ),
                                  ])
                                ],
                              ),
                            ]),
                      )),
                      Container(
                          // color: Colors.cyan,
                          child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "วันที่สิ้นสุดการลา",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
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
                                  Row(children: <Widget>[
                                    Text(
                                        '${dateend.day}/${dateend.month}/${dateend.year}'),
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),

                                      onPressed: () {
                                        selectDatePickerend(context);
                                      },
                                      //color: iBlueColor,
                                    ),
                                  ])
                                ],
                              ),
                            ]),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "หมายเหตุ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    SizedBox(
                                      height: 50,
                                      width: 250,
                                      child: TextFormField(
                                        onSaved: (String? comment) {
                                          myleave.comment = comment;
                                        },
                                      ),
                                    )
                                  ])
                                ],
                              ),
                            ]),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "เอกสารแนบ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    ElevatedButton(
                                      child: Text("Attach file"),
                                      // Icon:Icons.attach_file,
                                      onPressed: selectFile,
                                    ),
                                  ])
                                ],
                              ),
                            ]),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
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
                                    Text(_filename == null
                                        ? ''
                                        : _filename.toString()),
                                  ])
                                ],
                              ),
                            ]),
                      )),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              child: Text("Send"),
                              onPressed: () {
                                // final CollectionReference leaveCollection =
                                //     FirebaseFirestore.instance
                                //         .collection("leave");
                                NotificationApi.showNotification(
                                  title: 'Sarah Abs',
                                  body:
                                      'Hey! Do we have everything we need for the lunch on Friday?',
                                  payload: 'sarah.abs',
                                );

                                getDropDownItem();
                                if (myleave.startdate == null) {
                                  myleave.startdate = DateTime.now();
                                }
                                if (myleave.enddate == null) {
                                  myleave.enddate = DateTime.now();
                                }

                                String a = myleave.enddate.toString();
                                if (formKey.currentState!.validate() &&
                                    myleave.startdate!
                                        .isBefore(DateTime.parse(a))) {
                                  formKey.currentState!.save();

                                  context
                                      .read<EmpleavelistFormmodel>()
                                      .leaveid = leavetype;
                                  context
                                      .read<EmpleavelistFormmodel>()
                                      .startdate = myleave.startdate;
                                  context
                                      .read<EmpleavelistFormmodel>()
                                      .enddate = myleave.enddate;
                                  context
                                      .read<EmpleavelistFormmodel>()
                                      .comment = myleave.comment;

                                  List<Empleave> Listempleave = [];
                                  if (context
                                          .read<EmpleavelistFormmodel>()
                                          .empleaveList !=
                                      null) {
                                    Listempleave = context
                                        .read<EmpleavelistFormmodel>()
                                        .empleaveList;
                                  }
                                  Listempleave.add(Empleave(
                                    leaveid: leavetype,
                                    startdate: myleave.startdate,
                                    enddate: myleave.enddate,
                                    comment: myleave.comment,
                                  ));

                                  context
                                      .read<EmpleavelistFormmodel>()
                                      .empleaveList = Listempleave;

                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return leave_list();
                                  }));
                                }

                                // else if (formKey.currentState!.validate() &&
                                //     myleave.startdate!
                                //         .isAfter(DateTime.parse(a))) {
                                //   final snackBar = SnackBar(
                                //     content: const Text(
                                //         'กรุณาใส่วันที่เริ่มต้น สิ้นสุดลาให้ถูกต้อง'),
                                //     action: SnackBarAction(
                                //       label: 'Undo',
                                //       onPressed: () {
                                //         // Some code to undo the change.
                                //       },
                                //     ),
                                //   );

                                //   // Find the ScaffoldMessenger in the widget tree
                                //   // and use it to show a SnackBar.
                                //   ScaffoldMessenger.of(context)
                                //       .showSnackBar(snackBar);
                                // }
                                // formKey.currentState!
                                //     .save(); // เรียกใช้งาน onsave ของทุกตัว

                                // // await leaveCollection.add({
                                // //   "leavetype": "dd",
                                // //   "startdate": myleave.startdate,
                                // //   "enddate": myleave.enddate,
                                // //   "comment": myleave.comment,
                                // // });

                                // //formKey.currentState!.reset();

                                // // context.read<Empleave>().leaveid =
                                // //     _leaveid;
                                // // context.read<Empleave>().startdate =
                                // //     _startdate;
                                // // context.read<Empleave>().enddate =
                                // //     _enddate;
                                // // context.read<Empleave>().comment =
                                // //     _comment;
                                // context.read<Empleave>().leaveid =
                                //     myleave.leaveid;
                                // context.read<Empleave>().startdate =
                                //     myleave.startdate;
                                // context.read<Empleave>().enddate =
                                //     myleave.enddate;
                                // context.read<Empleave>().comment =
                                //     myleave.comment;
                                // //  Navigator.pop(context);
                                // if (myleave.startdate == null) {
                                //   myleave.startdate = DateTime.now();
                                // }
                                // if (myleave.enddate == null) {
                                //   myleave.enddate = DateTime.now();
                                // }
                                // // startdate = DateFormat('dd-MM-yyyy').format(myleave.startdate);

                                // Empleave statement = Empleave(
                                //     leaveid: myleave.leaveid,
                                //     startdate: myleave.startdate,
                                //     enddate: myleave.enddate,
                                //     comment: myleave.comment);

                                // var provider = Provider.of<Emp_leavelist>(
                                //     context,
                                //     listen: false);
                                // provider.addTransaction(statement);
                              }))
                    ])))));
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
}
