import 'package:first_app/controller/authen_controller.dart';
import 'package:first_app/controller/clock_controller.dart';
import 'package:first_app/model/Empleave_provider.dart';
import 'package:first_app/model/clock.dart';
import 'package:first_app/model/clock_provider.dart';
import 'package:first_app/model/leave_postapi_model.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_page.dart';
import 'profilem_page.dart';

class leavedetail_report extends StatefulWidget {
  
    var service = EAuthenServices();
  var controller;

  leavedetail_report() {
     
     controller = EAuthenController(service);
  }

  @override
  _leavedetail_reportState createState() => _leavedetail_reportState();
}

class _leavedetail_reportState extends State<leavedetail_report> {
  
  bool isLoading = false;
  List<LeavePostAPIModel> _empleaveList = List.empty();
  LeavePostAPIModel? model;


  @override
  void initState() {
    super.initState();
    setState(() {});
    widget.controller.onSync
        .listen((bool syncState) => setState(() => isLoading = syncState));
    _getEmpleaveList();
  }

  void _getEmpleaveList() async {
   

    int? empcode = context.read<UserProfileProvider>().empcode;
 
     var response = await widget.controller
        .getleave(empcode);
    setState(() {
      _empleaveList = response;

     
    });
    // var empclockList =
    //     await widget.controller.getTaskList(empcode, fromDate, toDate);
    // setState(() {
    //   _empclockList = empclockList;
    // });
  }

  final formKey = GlobalKey<FormState>();
  


  @override
  
  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: _empleaveList.isEmpty ? 1 : _empleaveList.length,
          itemBuilder: (context, index) {
            if (_empleaveList.isEmpty) {
              return Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 300),
                      child: Text('ไม่พบข้อมูลการลา')));
            }

           return Card(
              child: ListTile(
                tileColor: Colors.grey[100],
                onLongPress: () {},
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF21BFBD),
                  radius: 30,
                  child: FittedBox(
                    child: Text(
                      '${index + 1}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                ),
                title: Text( _empleaveList[index].leavetype == 1011? "ลาป่วย" 
                :_empleaveList[index].leavetype == 1030? "ลาพักผ่อน"
                :_empleaveList[index].leavetype == 1020? "ลากิจ": "ลาคลอด"),

                subtitle: Text('วันที่ลา ${_empleaveList[index].startdate!.day}/${_empleaveList[index].startdate!.month}/${_empleaveList[index].startdate!.year}'),
              

                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         EmpleaveDetail(Empleaves: _empclockList[index]),
                  //   ),
                  // );
                },
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    //_getHistory();
    if (context.read<ClockProvider>().empclockList != null) {
      _empleaveList = context.read<ClockProvider>().empclockList!;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('ภาพรวมการลาหยุด',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )
              //color: iWhiteColor),
              ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              iconSize: 28.0,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profile()));
              },
            ),
          ],
          //backgroundColor: iBlueColor,
          elevation: 0.0,
        ),
        body: Center(
          child: body,
        ));
  }

}

