import 'package:first_app/controller/authen_controller.dart';
import 'package:first_app/controller/clock_controller.dart';
import 'package:first_app/model/Empleave_provider.dart';
import 'package:first_app/model/authen_api_model.dart';
import 'package:first_app/model/clock.dart';
import 'package:first_app/model/clock_provider.dart';
import 'package:first_app/model/event.dart';
import 'package:first_app/model/leave_postapi_model.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/pages/utils.dart';
import 'package:first_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'profilem_page.dart';
import 'report_leavedetail_page .dart';

class leave_report extends StatefulWidget {
  final Event? event;

  leave_report({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _leave_reportState createState() => _leave_reportState();
}

class _leave_reportState extends State<leave_report> {
  var service = AuthService();
  late final EAuthenController authenController;

  final formKey = GlobalKey<FormState>();
  late DateTime fromDate;
  late DateTime toDate;
  String startdate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String enddate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  LeavePostAPIModel? model;
  @override
  void initState() {
    super.initState();

    fromDate = DateTime.now();
    toDate = DateTime.now();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now();
    } else {
      final event = widget.event!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "รายงานการลาหยุด",
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
                SizedBox(height: 12),
                buildDateTimePickers(),
                SizedBox(height: 12),
                SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text("เรียกดู", style: TextStyle(fontSize: 18)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            context.read<EmpleaveProvider>().empcode =
                                context.read<UserProfileProvider>().empcode;
                            context.read<EmpleaveProvider>().startdate = fromDate;
                            context.read<EmpleaveProvider>().enddate = toDate;

                            List<ClockList> Listempleave = [];
                            if (context.read<ClockProvider>().empclockList !=
                                null) {}
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return leavedetail_report();
                            }));
                          }
                        })),
              ]))),
    );
  }

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo(),
        ],
      );

  Widget buildFrom() => buildHeader(
        header: 'วันที่เริ่มต้น',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(fromDate),
                onClicked: () => pickFromDateTime(pickDate: true),
              ),
            ),
          ],
        ),
      );

  Widget buildTo() => buildHeader(
        header: 'วันที่สิ้นสุด',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(toDate),
                onClicked: () => pickToDateTime(pickDate: true),
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
