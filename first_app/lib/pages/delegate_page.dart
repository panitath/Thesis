import 'package:first_app/Screen/components/search_emp.dart';
import 'package:first_app/api/notification_api.dart';
import 'package:first_app/controller/authen_controller.dart';
import 'package:first_app/controller/empleave_controller.dart';
import 'package:first_app/model/delegate_model.dart';
import 'package:first_app/model/deligate_provider.dart';
import 'package:first_app/model/emp_api_model.dart';
import 'package:first_app/model/employee.dart';
import 'package:first_app/model/event.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/pages/EmailHelper.dart';
import 'package:first_app/pages/leave_page.dart';
import 'package:first_app/services/api_service.dart';
import 'package:first_app/services/empleave_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'profile_page.dart';
import 'profilem_page.dart';
import 'utils.dart';

class delegate extends StatefulWidget {
  final Event? event;
  const delegate({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _delegateState createState() => _delegateState();
}

class _delegateState extends State<delegate> {
  var service = EmpleaveServices();
  var controller;
  _delegateState() {
    controller = EmpleaveController(service);
  }

  final TextEditingController _empcodeController = new TextEditingController();
  final TextEditingController _fullnameController = new TextEditingController();
  Employee? empdelegate;

  int index = 0;
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
  final screens = [delegate(), leave()];
  final formKey = GlobalKey<FormState>();
  delegate mydelegate = delegate();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  bool isAllDay = false;

  @override
  void initState() {
    super.initState();
    DateTime now = new DateTime.now();
    DateTime date = new DateTime(now.year, now.month, now.day);
    fromDate = date;
    toDate = date;
    if (widget.event == null) {
      fromDate = date;
      toDate = date;
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
    }

    NotificationApi.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => delegate() //(payload: payload),
          ));

  @override
  Widget build(BuildContext context) {
    int? empcode = context.read<UserProfileProvider>().empcode;
    int? empcodedelegate = context.read<DelegateProvider>().empcodedelegate;
    String? manageremail = context.read<DelegateProvider>().manageremail;
     String? firstname = context.read<UserProfileProvider>().firstName  ;
     String? lastname=  context.read<UserProfileProvider>().lastName  ;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: Text('แจ้งมอบหมายปฏิบัติหน้าที่แทน',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ))),
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Stack(children: <Widget>[
                  Container(
                    height: size.height * .30,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFAD33),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(36),
                            bottomRight: Radius.circular(36))),
                  ),
                  SearchEmp(),
                  // SafeArea(
                  //     child: Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 20),
                  //         child: Column(children: <Widget>[
                  //           // Align(
                  //           //   alignment: Alignment.topRight,
                  //           //   child: Container(alignment: Alignment.center,
                  //           //   height: 52,
                  //           //   width: 52,
                  //           //   decoration: BoxDecoration(color: Colors.amber),

                  //           //   ),
                  //           // ),
                  //          SizedBox(height: 40),
                  //           Row(
                  //             children: [
                  //               Text("ค้นหารหัสพนักงาน\n",
                  //                   style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                  //             ],
                  //           ),

                  //           Container(
                  //               padding: EdgeInsets.symmetric(
                  //                   horizontal: 30, vertical: 5),
                  //               decoration: BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.circular(29.5),
                  //               ),
                  //               child: TextFormField(
                  //                   controller: _empcodeController,
                  //                   decoration: InputDecoration(
                  //                     hintText: "ค้นหา",
                  //                     border: InputBorder.none,
                  //                     suffixIcon: IconButton(
                  //                       onPressed: () => _getEmp(
                  //                           ),
                  //                       icon: Icon(Icons.search),
                  //                     ),
                  //                   ))),
                  //           TextFormField(
                  //             decoration: InputDecoration(
                  //               border: UnderlineInputBorder(),
                  //              // labelText: 'ชื่อ นามสกุล',
                  //               labelStyle: TextStyle(fontSize: 18),
                  //               enabledBorder: UnderlineInputBorder(),
                  //               focusedBorder: UnderlineInputBorder(),
                  //             ),
                  //             controller: _fullnameController,
                  //             validator: (value) {
                  //               if (value == null || value.isEmpty) {
                  //                 return 'กรุณาระบุชื่อ';
                  //               }
                  //               return null;
                  //             },
                  //           ),
                  SizedBox(height: 200),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: buildTitle(),
                  ),
                  SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: buildDateTimePickers(),
                  ),
                  SizedBox(height: 200),

                  Padding(
                    padding: const EdgeInsets.only(top: 520,left: 40,right:40),
                    child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                              ),
                            ),
                            child: Text("ส่ง", style: TextStyle(fontSize: 18)),
                            onPressed: () {
                              if (empcodedelegate == empcode) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'ไม่สามารถมอบหมายปฏิบัติหน้าที่แก่ตนเองได้'),
                                  duration: Duration(seconds: 5),
                                ));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                        title: Text('ยืนยัน'),
                                        content: Text(
                                            'ยืนยันการส่งมอบหมายปฏิบัติหน้าที่แทน'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('ไม่ใช่')),
                                          TextButton(
                                              onPressed: () {
                                                NotificationApi
                                                    .showNotification(
                                                  title: 'Delegate Request',
                                                  body:
                                                      '${firstname}' +'${lastname}' + ' มอบหมายปฏิบัติหน้าที่แทน', // +
                                                  //  leavetype,
                                                  payload: 'sarah.abs',
                                                );

                                                if (formKey.currentState!
                                                    .validate()) {
                                                  formKey.currentState!.save();
                                                  // context
                                                  //     .read<
                                                  //         DelegateProvider>()
                                                  //     .empcode = 50872;
                                                  // context
                                                  //     .read<
                                                  //         DelegateProvider>()
                                                  //     .leavetype = leavetype;
                                                  // context
                                                  //     .read<
                                                  //         DelegateProvider>()
                                                  //     .startdate = fromDate;
                                                  // context
                                                  //     .read<
                                                  //         DelegateProvider>()
                                                  //     .enddate = toDate;
                                                  // context
                                                  //     .read<
                                                  //         DelegateProvider>()
                                                  //     .empcodedelegate = 50877;
                                                  // context
                                                  //         .read<
                                                  //             DelegateProvider>()
                                                  //         .createdate =
                                                  //     DateTime.now();

                                                  // List<DelegateList>
                                                  //     Listempleave = [];
                                                  // if (context
                                                  //         .read<
                                                  //             DelegateProvider>()
                                                  //         .delegateList !=
                                                  //     null) {
                                                  //   // Listempleave = context
                                                  //   //     .read<EmpleaveProvider>()
                                                  //   //   .empleaveList;
                                                  // }
                                                  //add to State
                                                  // Listempleave.add(DelegateList(
                                                  //     50872,
                                                  //     leavetype,
                                                  //     19646,
                                                  //     'Charunee',
                                                  //     fromDate,
                                                  //     toDate,
                                                  //     int.parse(
                                                  //         _empcodeController
                                                  //             .text),
                                                  //     _fullnameController
                                                  //         .text,
                                                  //     DateTime.now()));

                                                  //add to firebase
                                                  
                                                  int? empcodemanager = context
                                                      .read<DelegateProvider>()
                                                      .empcodemanager;
                                                  String? namemanager = context
                                                      .read<DelegateProvider>()
                                                      .managername;
                                                  int? empcodedelegate = context
                                                      .read<DelegateProvider>()
                                                      .empcodedelegate;
                                                  String? delegatename = context
                                                      .read<DelegateProvider>()
                                                      .delegatename;
 EmailHelper email = EmailHelper();
                                   email.SendEmailDelegate(manageremail.toString(),firstname.toString(),lastname.toString(),fromDate,
                                                          toDate,leavetype,delegatename.toString());

                                                  controller
                                                      .addDelegate(new Delegate(
                                                          empcode!,
                                                          leavetype,
                                                          empcodemanager!,
                                                          namemanager!,
                                                          fromDate,
                                                          toDate,
                                                          empcodedelegate!,
                                                          delegatename!,
                                                          // int.parse(
                                                          //     _empcodeController
                                                          //         .text),
                                                          // _fullnameController
                                                          //.text,
                                                          DateTime.now()));

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              profile()));
                                                }
                                              },
                                              child: Text('ใช่'))
                                        ]);
                                  },
                                );
                              }
                            })),
                  ),
                ]))));
  }

  Widget buildTitle() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 250),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text("ประเภทลา",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(), buildTo(),
          // if (!isAllDay) buildTo(),
          // CheckboxListTile(
          //   controlAffinity: ListTileControlAffinity.leading,
          //   title: Text('All Day Event'),
          //   value: isAllDay,
          //   activeColor: Theme.of(context).primaryColor,
          //   onChanged: (value) => setState(() => isAllDay = value!),
          // )
        ],
      );

  Widget buildFrom() => Padding(
        padding: const EdgeInsets.only(top: 300),
        child: buildHeader(
          header: 'วันที่เริ่มต้นลา',
          child: Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 80.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: buildDropdownField(
                    text: Utils.toDate(fromDate),
                    onClicked: () => pickFromDateTime(pickDate: true),
                  ),
                ),
                // if (!isAllDay)
                //   Expanded(
                //     child: buildDropdownField(
                //       text: Utils.toTime(fromDate),
                //       onClicked: () => pickFromDateTime(pickDate: false),
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'วันที่สิ้นสุดลา',
        child: Padding(
          padding: const EdgeInsets.only(left: 50.0, right: 80.0),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: buildDropdownField(
                  text: Utils.toDate(toDate),
                  onClicked: () => pickToDateTime(pickDate: true),
                ),
              ),
              // Expanded(
              //   child: buildDropdownField(
              //     text: Utils.toTime(toDate),
              //     onClicked: () => pickToDateTime(pickDate: false),
              //   ),
              // ),
            ],
          ),
        ),
      );

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(header,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            child,
          ],
        ),
      );

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
      toDate = DateTime(date.year, date.month, date.day);
    }
    setState(() {
      fromDate = date;
      startdate = fromDate.toString();
    });
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() {
      toDate = date;
      enddate = toDate.toString();
    });
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
