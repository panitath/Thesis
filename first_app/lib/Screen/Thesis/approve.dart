
import 'package:first_app/Screen/Thesis/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'leave.dart';

class approve extends StatefulWidget {
  const approve({Key? key}) : super(key: key);

  @override
  _approveState createState() => _approveState();
}

class _approveState extends State<approve> {
  String startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String enddate =DateFormat('dd-MM-yyyy').format(DateTime.now());
  List leavelist = ['ลากิจ', 'ลาพักผ่อน', 'ลาคลอด'];
  String leavetype = 'ลากิจ';
  Future<void> _openDatepicker(BuildContext context) async {
    final DateTime? d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2030));

    if (d != null) {
      setState(() {
        startdate = DateFormat('dd-MM-yyyy').format(d);
      });
    }

    if (d != null) {
      setState(() {
        enddate = DateFormat('dd-MM-yyyy').format(d);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          //leading: Icon(Icons.menu),
          title: Text("อนุมัติการลา"),
        ),
        body: SingleChildScrollView(
          child: Card(
              child: Column(
            children: [
              Container(
                  // color: Colors.cyan,
                  child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      // Column(
                      //   children: <Widget>[
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Image.asset("assets/images/leaverequest.png"),
                      //     ),
                      //   ],
                      // ),
                    ]),
              )),
              Container(
                  // color: Colors.cyan,
                  // decoration: BoxDecoration(
                  //     color: Colors.green[400],
                  //     borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          // Text(
                          //   "แจ้งมอบหมายปฏิบัติหน้าที่แทน",
                          //   style: TextStyle(fontSize: 20),
                          // ),
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
                            "ชื่อพนักงาน",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(children: <Widget>[
                             Text(
                            "น.ส.ปณิตา  ธาราภูมิ",
                            style: TextStyle(fontSize: 20),
                          ),
                          ])
                        ],
                      ),
                    ]),
              )),
              Container(
                // decoration: BoxDecoration(
                //     color: Colors.yellow[600],
                //     borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text("ประเภทลา", style: TextStyle(fontSize: 20)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            DropdownButton<String>(
                              value: leavetype,
                              onChanged: (String? newValue) {
                                setState(() {
                                  leavetype = newValue!;
                                });
                              },
                              items: <String>[
                                'ลากิจ',
                                'ลาพักผ่อน',
                                'ลาคลอด'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
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
                            Text(enddate),
                            // IconButton(
                            //   icon: Icon(Icons.calendar_today),
                            //   onPressed: () {
                            //     _openDatepicker(context);
                            //   },
                            // ),
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
                            // IconButton(
                            //   icon: Icon(Icons.calendar_today),
                            //   onPressed: () {
                            //     _openDatepicker(context);
                            //   },
                            // ),
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
                              child: TextField(),
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
                            "หมายเหตุใหม่",
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
                              child: TextField(),
                            )
                          ])
                        ],
                      ),
                    ]),
              )),Container(
                  child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "หมายเหตุใหม่",
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
                              child: TextField(),
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
                  child: Text("อนุมัติ"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return profile();
                    }));
                  },
                ),
              ),
               SizedBox(
                width: 150,
                 height: 10),
              SizedBox(
                width: double.infinity,
                 height: 50,
                child: ElevatedButton(
                  child: Text("ปฏิเสธ"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return profile();
                    }));
                  },
                ),
              ),
            ],
          )),
        ));
  }
}
