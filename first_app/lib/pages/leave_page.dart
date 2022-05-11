import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:first_app/api/notification_api.dart';
import 'package:first_app/controller/empleave_controller.dart';
import 'package:first_app/model/Empleave_provider.dart';
import 'package:first_app/model/delegate_model.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/event.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/pages/EmailHelper.dart';
import 'package:first_app/pages/approve_page.dart';
import 'package:first_app/pages/leavelist_page.dart';
import 'package:first_app/services/empleave_services.dart';
import 'package:first_app/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:first_app/services/firebase_api.dart';

class leave extends StatefulWidget {
  var service = EmpleaveServices();
  var controller;
  Event? event;
  leave() {
    controller = EmpleaveController(service);
  }

  @override
  _leaveState createState() => _leaveState();
}

class _leaveState extends State<leave> {
  var service = EmpleaveServices();
  var controller;
  _leaveState() {
    controller = EmpleaveController(service);
  }

  List leavelist = ['ลาป่วย', 'ลากิจ', 'ลาพักผ่อน', 'ลาคลอด'];
  String leavetype = 'ลากิจ';
  String leaveid = "";
  int? leavetypeid;
  File? file;

  String startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String enddate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  String? _filename;

  void getDropDownItem() {
    setState(() {
      leaveid = leavetype;

      // myleave.leaveid = leaveid;
    });
  }

  final formKey = GlobalKey<FormState>();
  final leaveidController = TextEditingController();
  final startdateController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  bool isAllDay = false;
  String? comment;
  int? empcode;
  UploadTask? task;
  String? firstname;

  @override
  void initState() {
    super.initState();
    NotificationApi.init(initScheduled: true);
    listenNotifications();

    //getEmpDelegate();
    fromDate = DateTime.now();
    toDate = DateTime.now(); //.add(Duration(hours: 2));

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now(); //.add(Duration(hours: 2));
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      isAllDay = event.isAllDay;
    }
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Approve() //(payload: payload),
          ));

  var response;
  int? empcodedelegate;
  Delegate? model;

  _getEmpDelegate() async {
    DateTime checkfromDate =
        new DateTime(fromDate.year, fromDate.month, fromDate.day);
    DateTime checktoDate = new DateTime(toDate.year, toDate.month, toDate.day);

    response = await widget.controller
        .CheckEmpDelegate(empcode.toString(), leavetype, fromDate, toDate);
    model = response;
    empcodedelegate = model!.empcodedelegate;
    return model;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    empcode = context.read<UserProfileProvider>().empcode;
    firstname = context.read<UserProfileProvider>().firstName;
    String? lastname = context.read<UserProfileProvider>().lastName;
    int? empcodemanager = context.read<EmpleaveProvider>().empcodemanager;
    String? manageremail = context.read<EmpleaveProvider>().manageremail;
    String managername =
        context.read<EmpleaveProvider>().managername.toString();

    return Scaffold(
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
              padding: EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                buildTitle(),
                SizedBox(height: 12),
                buildDateTimePickers(),
                SizedBox(height: 12),
                buildDescription(),
                buildAttachfile(),
                buildAttachfileName(),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text("ส่ง", style: TextStyle(fontSize: 18)),
                        onPressed: () async {
                          if (leavetype != 'ลาป่วย') {
                            try {
                              var model = await _getEmpDelegate();

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text('ยืนยัน'),
                                      content: Text('ยืนยันการลา'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text('ไม่ใช่')),
                                        TextButton(
                                          child: Text('ใช่'),
                                          onPressed: () {
                                            NotificationApi.showNotification(
                                              title: 'Leave Request',
                                              body: '${firstname}' +
                                                  '  ' +
                                                  '${lastname}' +
                                                  ' ขออนุมัติการ' +
                                                  leavetype,
                                              payload: 'sarah.abs',
                                            );

                                            getDropDownItem();

                                            EmailHelper email = EmailHelper();
                                            email.SendEmailLeave(
                                                manageremail.toString(),
                                                firstname.toString(),
                                                lastname.toString());

                                            if (formKey.currentState!
                                                .validate()) {
                                              formKey.currentState!.save();
                                              empcode;
                                              context
                                                  .read<EmpleaveProvider>()
                                                  .leavetype = leavetype;
                                              context
                                                  .read<EmpleaveProvider>()
                                                  .startdate = fromDate;
                                              context
                                                  .read<EmpleaveProvider>()
                                                  .enddate = toDate;
                                              context
                                                      .read<EmpleaveProvider>()
                                                      .comment =
                                                  descriptionController.text;
                                              context
                                                  .read<EmpleaveProvider>()
                                                  .status = 'sent';
                                              context
                                                  .read<EmpleaveProvider>()
                                                  .createdate = DateTime.now();

                                              List<EmpleaveList> Listempleave =
                                                  [];
                                              if (context
                                                      .read<EmpleaveProvider>()
                                                      .empleaveList !=
                                                  null) {
                                                // Listempleave = context
                                                //     .read<EmpleaveProvider>()
                                                //   .empleaveList;
                                              }

                                              if (leavetype == 'ลาพักผ่อน') {
                                                leavetypeid = 1030;
                                              } else if (leavetype ==
                                                  'ลาป่วย') {
                                                leavetypeid = 1011;
                                              } else if (leavetype ==
                                                  'ลาคลอด') {
                                                leavetypeid = 1060;
                                              } else if (leavetype == 'ลากิจ') {
                                                leavetypeid = 1020;
                                              }

                                              //add to State
                                              Listempleave.add(EmpleaveList(
                                                  empcode!,
                                                  firstname.toString(),
                                                  lastname.toString(),
                                                  leavetypeid!,
                                                  leavetype,
                                                  fromDate,
                                                  toDate,
                                                  descriptionController.text,
                                                  'sent',
                                                  empcodemanager!,
                                                  managername,
                                                  DateTime.now()));

                                              //add to firebase

                                              controller.addEmpLeave(
                                                  new Empleave(
                                                      empcode!,
                                                      firstname.toString(),
                                                      lastname.toString(),
                                                      leavetypeid!,
                                                      leavetype,
                                                      fromDate,
                                                      toDate,
                                                      descriptionController
                                                          .text,
                                                      'sent',
                                                      empcodemanager,
                                                      managername,
                                                      DateTime.now()));

                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return Leave_list();
                                              }));
                                            }
                                          },
                                        ),
                                      ]);
                                },
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'ไม่มีการมอบหมายปฏิบัติหน้าที่ในวันลาดังกล่าว'),
                                duration: Duration(seconds: 5),
                              ));
                            }
                          } else {
                            // ลาป่วย
                            if(fromDate.isAfter(DateTime.now())) {
                               ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'ไม่สามารถสร้างวันลาป่วยล่วงหน้าได้'),
                                duration: Duration(seconds: 5),
                              ));

                            }
                            else{

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text('ยืนยัน'),
                                    content: Text('ยืนยันการลา'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('ไม่ใช่')),
                                      TextButton(
                                        child: Text('ใช่'),
                                        onPressed: () {
                                          NotificationApi.showNotification(
                                            title: 'Leave Request',
                                            body: '${firstname}' +
                                                '  ' +
                                                '${lastname}' +
                                                ' ขออนุมัติการ' +
                                                leavetype,
                                            payload: 'sarah.abs',
                                          );

                                          getDropDownItem();

                                          EmailHelper email = EmailHelper();
                                          email.SendEmailLeave(
                                              manageremail.toString(),
                                              firstname.toString(),
                                              lastname.toString());

                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                            empcode;
                                            context
                                                .read<EmpleaveProvider>()
                                                .leavetype = leavetype;
                                            context
                                                .read<EmpleaveProvider>()
                                                .startdate = fromDate;
                                            context
                                                .read<EmpleaveProvider>()
                                                .enddate = toDate;
                                            context
                                                    .read<EmpleaveProvider>()
                                                    .comment =
                                                descriptionController.text;
                                            context
                                                .read<EmpleaveProvider>()
                                                .status = 'sent';
                                            context
                                                .read<EmpleaveProvider>()
                                                .createdate = DateTime.now();

                                            List<EmpleaveList> Listempleave =
                                                [];
                                            if (context
                                                    .read<EmpleaveProvider>()
                                                    .empleaveList !=
                                                null) {
                                              // Listempleave = context
                                              //     .read<EmpleaveProvider>()
                                              //   .empleaveList;
                                            }

                                            if (leavetype == 'ลาพักผ่อน') {
                                              leavetypeid = 1030;
                                            } else if (leavetype == 'ลาป่วย') {
                                              leavetypeid = 1011;
                                            } else if (leavetype == 'ลาคลอด') {
                                              leavetypeid = 1060;
                                            } else if (leavetype == 'ลากิจ') {
                                              leavetypeid = 1020;
                                            }

                                            //add to State
                                            Listempleave.add(EmpleaveList(
                                                empcode!,
                                                firstname.toString(),
                                                lastname.toString(),
                                                leavetypeid!,
                                                leavetype,
                                                fromDate,
                                                toDate,
                                                descriptionController.text,
                                                'sent',
                                                empcodemanager!,
                                                managername,
                                                DateTime.now()));

                                            //add to firebase

                                            controller.addEmpLeave(new Empleave(
                                                empcode!,
                                                firstname.toString(),
                                                lastname.toString(),
                                                leavetypeid!,
                                                leavetype,
                                                fromDate,
                                                toDate,
                                                descriptionController.text,
                                                'sent',
                                                empcodemanager,
                                                managername,
                                                DateTime.now()));

                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return Leave_list();
                                            }));
                                          }
                                        },
                                      ),
                                    ]);
                              },
                            );
                          }}
                        })),
              ]))), //bottomNavigationBar: BottomNavigation(),
    );
  }

  Future selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File c = File(result.files.single.path.toString());
      setState(() {
        file = c;
        _filename = 'ชื่อไฟล์ :' + result.names.toString();
      });
      uploadFile();
    } else {
      // User canceled the picker
    }
  }

  Future uploadFile() async {
    var ref = FirebaseStorage.instance
        .ref()
        .child("files")
        .child("/" + '${empcode}' + '_${fromDate}');
    UploadTask task = ref.putFile(file!);

    TaskSnapshot snapshot = await task;
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');
  }

  Widget buildTitle() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        Column(
          children: <Widget>[
            Text("ประเภทลา",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        Column(
          children: <Widget>[
            DropdownButton<String>(
              value: leavetype,
              items: <String>[
                'ลาป่วย',
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
      ]);

  Widget buildDescription() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'หมายเหตุ',
        ),

        textInputAction: TextInputAction.newline,
        maxLines: 3,
        //\ onFieldSubmitted: (_) => saveForm(),
        onChanged: (String? comment) {
          // myleave.comment = comment;
        },
        controller: descriptionController,
      );

  Widget buildAttachfile() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
        Column(
          children: <Widget>[
            Text("เอกสารแนบ", style: TextStyle(fontSize: 18)),
          ],
        ),
        Column(
          children: <Widget>[
            Row(children: <Widget>[
              IconButton(
                icon: const Icon(Icons.attach_file),
                // Icon:Icons.attach_file,
                onPressed: selectFile,
              ),
            ])
          ],
        ),
      ]);
  Widget buildAttachfileName() =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[
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
      ]);

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

  Widget buildFrom() => buildHeader(
        header: 'วันที่เริ่มต้นลา',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
            if (!isAllDay)
              Expanded(
                child: buildDropdownField(
                  text: Utils.toTime(fromDate),
                  onClicked: () => pickFromDateTime(pickDate: false),
                ),
              ),
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'วันที่สิ้นสุดลา',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(toDate),
                onClicked: () => pickToDateTime(pickDate: false),
              ),
            ),
          ],
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
      toDate =
          DateTime(date.year, date.month, date.day, toDate.hour, toDate.minute);
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
