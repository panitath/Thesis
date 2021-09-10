import 'package:first_app/Screen/Thesis/approve.dart';
import 'package:first_app/model/emp_leave.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class leave extends StatefulWidget {
  const leave({Key? key}) : super(key: key);

  @override
  _leaveState createState() => _leaveState();
}

class _leaveState extends State<leave> {
  List leavelist = ['ลากิจ', 'ลาพักผ่อน', 'ลาคลอด'];
  String leavetype = 'ลากิจ'; String leaveid = "";
  
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
      });
    }
  }

  
void getDropDownItem(){
 
    setState(() {
      leaveid = leavetype;
     myleave.leaveid = leaveid;
     
    });
  }
  

   final formKey = GlobalKey<FormState>();
  emp_leave myleave = emp_leave();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("สร้างคำขอลาหยุด"),
          leading: Icon(Icons.menu),
        ),
        body: Card(
          child:Form(
            key: formKey,
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
                             
                              items: <String>['ลากิจ', 'ลาพักผ่อน', 'ลาคลอด']
                                  .map<DropdownMenuItem<String>>((String value) {
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
                                _openDatepickerstart(context).then((date){

                                  setState(() {
                                    myleave.startdate = DateTime.parse(startdate);
                                  });


                                });
                               
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
                            // TextFormField(
                            //     onSaved: (String? endate){
                            //       myleave.enddate = DateTime.parse(enddate);
                            //     }),
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
                                onSaved: (String? comment){
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
                  onPressed: () {getDropDownItem();
                    formKey.currentState!.save(); // เรียกใช้งาน onsave ของทุกฟิล
                    
                    print("${myleave.comment}");
                    print("${myleave.leaveid}");
                     print("${myleave.enddate}");
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return approve();
                    // })
                    // );
                  },
                ),
              ),
                      ],
                    ),
            ))));
  }
}
