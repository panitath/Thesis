import 'package:first_app/Screen/Thesis/approve.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class leave extends StatefulWidget {
  const leave({Key? key}) : super(key: key);

  @override
  _leaveState createState() => _leaveState();
}

class _leaveState extends State<leave> {
  List leavelist = ['ลากิจ', 'ลาพักผ่อน', 'ลาคลอด'];
  String leavetype = 'ลากิจ';
  Future<void> _openDatepicker(BuildContext context) async {
    final DateTime? d = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2030));
  }

  String startdate = DateTime.now().toString();
  String enddate = DateTime.now().toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สร้างคำขอลาหยุด"),
          leading: Icon(Icons.menu),
        ),
        body: Card(
            child:  SingleChildScrollView(
              child: Column(
                      children: [
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
                              items: <String>['ลากิจ', 'ลาพักผ่อน', 'ลาคลอด']
                                  .map<DropdownMenuItem<String>>((String value) {
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
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () {
                                _openDatepicker(context);
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
                                _openDatepicker(context);
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
                  child: Text("Send"),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return approve();
                    }));
                  },
                ),
              ),
                      ],
                    ),
            )));
  }
}
