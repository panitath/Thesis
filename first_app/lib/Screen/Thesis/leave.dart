import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Screen/Thesis/leavelist.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/emp_leavelist.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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

  Future<void> _openDatepickerstart(BuildContext context) async {
    final DateTime? d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2030));

    if (d != null) {
      setState(() {
        startdate = DateFormat('dd-MM-yyyy').format(d);
        myleave.startdate = d;
      });
    } else {
      setState(() {
        startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
        myleave.startdate = d;
      });
    }
  }

  Future<void> _openDatepickerend(BuildContext context) async {
    final DateTime? d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2030));

    if (d != null) {
      setState(() {
        enddate = DateFormat('dd-MM-yyyy').format(d);
        myleave.enddate = d;
      });
    }
  }

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
                                        'ลาคลอด'
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
                                    "วันที่เริ่มต้น",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text(startdate),
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      onPressed: () {
                                        _openDatepickerstart(context);
                                        // print(context);
                                        // then((date){

                                        //   setState(() {
                                        //     myleave.startdate = DateTime.parse(date);
                                        //   });

                                        // }
                                        // );
                                      },
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
                                    "วันที่สิ้นสุด",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text(enddate),
                                    IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      onPressed: () {
                                        _openDatepickerend(context);
                                      },
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
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              child: Text("Send"),
                              onPressed: () async {
                                final CollectionReference leaveCollection =
                                    FirebaseFirestore.instance
                                        .collection("leave");
                                getDropDownItem();

                                formKey.currentState!
                                    .save(); // เรียกใช้งาน onsave ของทุกตัว

                                await leaveCollection.add({
                                  "leavetype": "dd",
                                  "startdate": myleave.startdate,
                                  "enddate": myleave.enddate,
                                  "comment": myleave.comment,
                                });

                                //formKey.currentState!.reset();

                                // context.read<Empleave>().leaveid =
                                //     _leaveid;
                                // context.read<Empleave>().startdate =
                                //     _startdate;
                                // context.read<Empleave>().enddate =
                                //     _enddate;
                                // context.read<Empleave>().comment =
                                //     _comment;
                                context.read<Empleave>().leaveid =
                                    myleave.leaveid;
                                context.read<Empleave>().startdate =
                                    myleave.startdate;
                                context.read<Empleave>().enddate =
                                    myleave.enddate;
                                context.read<Empleave>().comment =
                                    myleave.comment;
                                //  Navigator.pop(context);
                                if (myleave.startdate == null) {
                                  myleave.startdate = DateTime.now();
                                }
                                if (myleave.enddate == null) {
                                  myleave.enddate = DateTime.now();
                                }
                                // startdate = DateFormat('dd-MM-yyyy').format(myleave.startdate);

                                Empleave statement = Empleave(
                                    leaveid: myleave.leaveid,
                                    startdate: myleave.startdate,
                                    enddate: myleave.enddate,
                                    comment: myleave.comment);

                                var provider = Provider.of<Emp_leavelist>(
                                    context,
                                    listen: false);
                                provider.addTransaction(statement);

                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return leave_list();
                                }));
                              }))
                    ])))));
  }
}
