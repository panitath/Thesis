// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:first_app/Screen/Thesis/Deligate.dart';
import 'package:first_app/Screen/Thesis/approve.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Screen/Thesis/leavelist.dart';
import 'package:first_app/Screen/Thesis/utils.dart';
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
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

  // final Future<FirebaseApp> firebase =
  //     Firebase.initializeApp(); // เตรียม Firebase
  @override
  void initState() {
    super.initState();
    fromDate = DateTime.now();
    toDate = DateTime.now().add(Duration(hours: 2));

    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Approve() //(payload: payload),
          ));

  @override
  Widget build(BuildContext context) {
   CollectionReference users = FirebaseFirestore.instance.collection('todos');

    Future<void> addUser() {
      return users
          .add({
            'empcode': 50872, 
            'leaveid': 2, 
            'startdate': DateTime.now() ,
            'enddate': DateTime.now(), 
            'comment': 'dd' // 42
          })
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Size size = MediaQuery.of(context).size;
    return
        // Consumer<emp_leave>(
        //   builder: (context, emp_leave, child) =>

        Scaffold(
      appBar: AppBar(
          title: Text(
        "สร้างคำขอลาหยุด",
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
              child: Column(children: [
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
                      Column(
                        children: <Widget>[
                          Text("ประเภทลา", style: TextStyle(fontSize: 18)),
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
                            ].map<DropdownMenuItem<String>>((String value) {
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
            
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, ),
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
                                "วันที่เริ่มต้นการลา",
                                style:
                                    TextStyle(fontSize: 15, color: Colors.black),
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
                                Text(Utils.toDate(fromDate)),
                                IconButton(
                                  icon: Icon(Icons.calendar_today),

                                  onPressed: () {
                                    pickFromDateTime(pickDate: true);
                                  },
                                  //color: iBlueColor,
                                ),
                              ])
                            ],
                          ),
                        ]),
                  )),
            
            // Padding(
            //    padding: const EdgeInsets.only(left: 12.0, right: 12.0, ),
              Container(
                decoration: BoxDecoration(
                   // color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(60),
                        bottomRight: Radius.circular(60))),
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
                            style: TextStyle(fontSize: 15, color: Colors.black),
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
                              Utils.toDate(toDate),
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today),

                              onPressed: () {
                                pickToDateTime(pickDate: true);
                              },
                              //color: iBlueColor,
                            ),
                          ])
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  // decoration: BoxDecoration(
                  //     color: Colors.grey[300],
                  //     borderRadius: BorderRadius.only(
                  //         topRight: Radius.circular(36.0),
                  //         topLeft: Radius.circular(36.0),
                  //         bottomLeft: Radius.circular(36),
                  //         bottomRight: Radius.circular(36))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "หมายเหตุ",
                                style: TextStyle(fontSize: 18),
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
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.all(Radius.circular(30))),
                                      filled: false,fillColor: Colors.grey,),
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
            ),
            Container(
               
              child: Padding(
                padding: const EdgeInsets.only(left:20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "เอกสารแนบ",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                             IconButton(
                              icon : const Icon(Icons.attach_file),
                              // Icon:Icons.attach_file,
                              onPressed: selectFile,
                            ),
                          ])
                        ],
                      ),
                    ]),
              ),
            ),
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
                          Text(_filename == null ? '' : _filename.toString()),
                        ])
                      ],
                    ),
                  ]),
            )),
            SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text("ส่ง"),
                    onPressed: () {
                      // final CollectionReference leaveCollection =
                      //     FirebaseFirestore.instance
                      //         .collection("leave");
                      NotificationApi.showNotification(
                        title: 'Leave Request',
                        body: 'น.ส.ปณิตา ธาราภูมิ ขออนุมัติการ' + leavetype,
                        payload: 'sarah.abs',
                      );
                      addUser();

                      getDropDownItem();
                      if (myleave.startdate == null) {
                        myleave.startdate = DateTime.now();
                      }
                      if (myleave.enddate == null) {
                        myleave.enddate = DateTime.now();
                      }

                      String a = myleave.enddate.toString();
                      if (formKey.currentState!.validate() &&
                          myleave.startdate!.isBefore(DateTime.parse(a))) {
                        formKey.currentState!.save();

                        context.read<EmpleavelistFormmodel>().leaveid =
                            leavetype;
                        context.read<EmpleavelistFormmodel>().startdate =
                            myleave.startdate;
                        context.read<EmpleavelistFormmodel>().enddate =
                            myleave.enddate;
                        context.read<EmpleavelistFormmodel>().comment =
                            myleave.comment;

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

                        context.read<EmpleavelistFormmodel>().empleaveList =
                            Listempleave;

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

    setState(() => fromDate = date);
    myleave.startdate = date;
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);

    myleave.enddate = date;
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
