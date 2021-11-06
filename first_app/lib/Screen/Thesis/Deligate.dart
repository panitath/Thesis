import 'package:first_app/Screen/Thesis/approve.dart';
import 'package:first_app/Screen/Thesis/leave.dart';
import 'package:first_app/Screen/Thesis/profile.dart';
import 'package:first_app/Screen/Thesis/utils.dart';
import 'package:first_app/api/notification_api.dart';
import 'package:first_app/model/deligate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class deligate extends StatefulWidget {
  const deligate({Key? key}) : super(key: key);

  @override
  _deligateState createState() => _deligateState();
}

class _deligateState extends State<deligate> {
  String startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String enddate = DateFormat('dd-MM-yyyy').format(DateTime.now());
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

  int currentIndex = 0;
  final screens = [deligate(), leave()];
  final formKey = GlobalKey<FormState>();
  Deligate mydeligate = Deligate();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;

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
      MaterialPageRoute(builder: (context) => deligate() //(payload: payload),
          ));

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Form(
          key: formKey,
          child: Stack(
            children: <Widget>[
              Container(
                height: size.height * .40,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36))),
              ),
              SafeArea(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: <Widget>[
                  // Align(
                  //   alignment: Alignment.topRight,
                  //   child: Container(alignment: Alignment.center,
                  //   height: 52,
                  //   width: 52,
                  //   decoration: BoxDecoration(color: Colors.amber),

                  //   ),
                  // ),
                  Text("\nHi Panita\nแจ้งมอบหมายปฏิบัติหน้าที่แทน\n\n",
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Text("ค้นหารหัสพนักงาน\n"),
                    ],
                  ),

                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "ค้นหา", border: InputBorder.none),
                        //  onSaved: (String empid){

                        //  },
                      )),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
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
                                  Text("ประเภทลา",
                                      style: TextStyle(fontSize: 18)),
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
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
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
                                style: TextStyle(fontSize: 18),
                              ),
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
                                style: TextStyle(fontSize: 18),
                              ),
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
                                ),
                              ])
                            ],
                          ),
                        ]),
                  )),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text("ส่ง"),
                      onPressed: () {
                        NotificationApi.showNotification(
                        title: 'Leave Request',
                        body: 'น.ส.ปณิตา ธาราภูมิ มอบมายให้' + leavetype,
                        payload: 'sarah.abs',
                      );
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return profile();
                        }));
                      },
                    ),
                  )
                ]),
              ))
            ],
          )),
    ));
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
    mydeligate.startdate = date;
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);

    mydeligate.enddate = date;
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
