import 'package:first_app/controller/task_controller.dart';
import 'package:first_app/model/event.dart';
import 'package:first_app/model/task_provider.dart';
import 'package:first_app/model/task.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/pages/calendar_page.dart';
import 'package:first_app/services/task_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils.dart';

class EventEditPage extends StatefulWidget {
  final Task? event;
  const EventEditPage({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  _EventEditPageState createState() => _EventEditPageState();
}

class _EventEditPageState extends State<EventEditPage> {
  var controller;
  var service = TaskService();
  _EventEditPageState() {
    controller = TaskController(service);
  }

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  late DateTime fromDate;
  late DateTime toDate;
  bool isAllDay = false;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = DateTime.now();
      //toDate = DateTime.now().add(Duration(hours: 2));
    } else {
      final event = widget.event!;

      titleController.text = event.title;
      descriptionController.text = event.description;
      fromDate = event.from;
      toDate = event.to;
      isAllDay = event.isAllDay;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildEditingActions(),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                buildTitle(),
                SizedBox(height: 12),
                buildDateTimePickers(),
                SizedBox(height: 12),
                buildDescription(),
              ],
            ),
          ),
        ),
      );

  List<Widget> buildEditingActions() => [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: saveForm,
          icon: Icon(Icons.done),
          label: Text('บันทึก'),
        ),
      ];

  Widget buildTitle() => TextFormField(
        style: TextStyle(fontSize: 24),
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          hintText: 'หัวข้อ',
        ),
        onFieldSubmitted: (_) => saveForm(),
        validator: (title) =>
            title != null && title.isEmpty ? 'Title cannot be empty' : null,
        controller: titleController,
      );

  Widget buildDescription() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'รายละเอียด',
        ),
        textInputAction: TextInputAction.newline,
        maxLines: 5,
        onFieldSubmitted: (_) => saveForm(),
        controller: descriptionController,
      );

  Widget buildDateTimePickers() => Column(
        children: [
          buildFrom(),
          buildTo()
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

    setState(() => fromDate = date);
  }

  Future pickToDateTime({required bool pickDate}) async {
    final date = await pickDateTime(
      toDate,
      pickDate: pickDate,
      firstDate: pickDate ? fromDate : null,
    );
    if (date == null) return;

    setState(() => toDate = date);
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

  Future saveForm() async {
    
    int? empcode = context.read<UserProfileProvider>().empcode;
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      context.read<TaskProvider>().empcode = empcode;
      context.read<TaskProvider>().title = titleController.text;
      context.read<TaskProvider>().description = descriptionController.text;
      context.read<TaskProvider>().from = fromDate;
      context.read<TaskProvider>().to = toDate;

      List<TaskList> Listtask = [];
      if (context.read<TaskProvider>().taskList != null) {}
      //add to State
      Listtask.add(TaskList(
          empcode!,
          titleController.text,
          descriptionController.text,
          fromDate,
          toDate,
          // Color(0xFFFFFF),
          true));

      //add to firebase
      controller.addTask(new Task(
          empcode,
          titleController.text,
          descriptionController.text,
          fromDate,
          toDate,
          // Color(0xFFFFFF),
          false));

      final event = Task(
        empcode,
        titleController.text,
        descriptionController.text,
        fromDate,
        isAllDay ? fromDate : toDate,
       
        true,
      );

      final isEditing = widget.event != null;
      final provider = Provider.of<TaskProvider>(context, listen: false);

      if (isEditing) {
        provider.editEvent(event, widget.event!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Calendar(),
          ),
        );
        //Navigator.pop(context);
      } else {
        provider.addEvent(event);
      }
       
   //Navigator.push( context, MaterialPageRoute( builder: (context) => Calendar()), ).then((value) => setState(() {}));
     // Navigator.of(context).pop();
   Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (context) => Calendar(),
  ),
);
   
   
    }
  }
}
