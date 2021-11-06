
import 'package:first_app/Screen/Thesis/Deligate.dart';
import 'package:first_app/Screen/Thesis/leave.dart';
import 'package:first_app/Screen/Thesis/profile.dart';
import 'package:first_app/model/Empleavelist_form_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';



class Approve extends StatefulWidget {
  const Approve({Key? key}) : super(key: key);

  @override
  _ApproveState createState() => _ApproveState();
}

class _ApproveState extends State<Approve> {
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
          child: Consumer<EmpleavelistFormmodel>(
          builder: (context, form, child) {
           return  Column(
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
                             Text('${form.leaveid}',),
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
                            
                            Text('${form.startdate}',),
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
                            
                            Text('${form.enddate}'),
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
                              child: Text('${form.comment}'== ''  ? '-' : '${form.comment}'.toString()),
                              

                              
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
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.all(Radius.circular(30))),
                                      filled: false,fillColor: Colors.grey
                                    )))
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
                  child: Text("อนุมัติ"),
                  onPressed: () {

                   
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return deligate();
                    }));
                  },
                ),
              ),
               SizedBox(
                width: 150,
                 height: 10),
              SizedBox(
               width: 350,
                height: 50,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  child: Text("ปฏิเสธ"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return deligate();
                    }));
                  },
                ),
              ),
            ],
          );
          
          }
    ),
  )
  );
        
  }
}
