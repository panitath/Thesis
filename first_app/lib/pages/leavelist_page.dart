import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/controller/empleave_controller.dart';
import 'package:first_app/model/Empleave_provider.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/leave_postapi_model.dart';
import 'package:first_app/services/empleave_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_page.dart';
import 'profilem_page.dart';

class Leave_list extends StatefulWidget {
  var service = EmpleaveServices();
  var controller;

  Leave_list() {
    controller = EmpleaveController(service);
    //  controller = EAuthenController(service1);
  }

  @override
  _Leave_listState createState() => _Leave_listState();
}

class _Leave_listState extends State<Leave_list> {
  List<Empleave> _empleaveList = List.empty();
  bool isLoading = false;
  EmpleaveProvider _profile = EmpleaveProvider();
  final auth = FirebaseAuth.instance;
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
    var empleaveList = await widget.controller.fecthEmpleaveList();
    setState(() {
      _empleaveList = empleaveList;
    });
  }

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
                title: Text('${_empleaveList[index].leavetype}'),
                subtitle: Text(
                    'วันที่ลา ${_empleaveList[index].startdate.day}/${_empleaveList[index].startdate.month}/${_empleaveList[index].startdate.year}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EmpleaveDetail(Empleaves: _empleaveList[index]),
                    ),
                  );
                },
              ),
            );
          });

  @override
  Widget build(BuildContext context) {
    //_getHistory();
    if (context.read<EmpleaveProvider>().empleaveList != null) {
      _empleaveList = context.read<EmpleaveProvider>().empleaveList!;
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

//    return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'ภาพรวมการลาหยุด',
//               style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               //color: Colors.white,
//             ),
//           ),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.logout),
//               iconSize: 28.0,
//                onPressed: () {
//               //   Navigator.push(context,
//               //       MaterialPageRoute(builder: (context) => LogInScreen())
//               //   );
//               },
//             ),
//           ],
//           //backgroundColor: Color(0xFF473F97),
//         ),
//         //
//         body: ListView.builder(
//         itemCount: _empleaveList.length,
//         itemBuilder: (context, int index) {

//           //User data = provider.users[index];
//           return Card(

//             child: ListTile(
//               leading: CircleAvatar(
//                 radius: 20,
//                 child: FittedBox(
//                   child: Text('${index+1}',
//                     //style: TextStyle(color: iWhiteColor,fontSize: 20),
//                   ),
//                 ),
//               ),
//               title: Text('${_empleaveList[index].leaveid}'),
//               subtitle: Text('${_empleaveList[index].startdate}'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>  EmpleaveDetail(Empleaves: _empleaveList[index]),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class EmpleaveDetail extends StatefulWidget {
  final Empleave Empleaves;

  const EmpleaveDetail({Key? key, required this.Empleaves}) : super(key: key);

  @override
  _EmpleaveDetailState createState() => _EmpleaveDetailState();
}

class _EmpleaveDetailState extends State<EmpleaveDetail> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('รายละเอียดการลา',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
          //backgroundColor: iBlueColor,
          actions: [
            // IconButton(
            //   onPressed: () {
            //     // Navigator.push(
            //     //   context,
            //     //   MaterialPageRoute(builder: (context) => LogInScreen()),
            //     // );
            //   },
            // icon: Icon(Icons.logout),
            // ),
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: Column(children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 10.0, ),

                  Container(
                    //height: size.height * .10,
                    decoration: BoxDecoration(
                        //color: Colors.grey[200],
                        //border: Border.all(color: Colors.green,width: 3.0,),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0))),

                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: <Widget>[
                                Text("ประเภทลา",
                                    style: TextStyle(fontSize: 18)),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Text('${widget.Empleaves.leavetype}',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ]),
                  ),

                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(60.0),
                                // topLeft: Radius.circular(60.0),
                                // bottomLeft: Radius.circular(36),
                                // bottomRight: Radius.circular(36))
                                )),
                        // color: Colors.cyan,
                        // child: Padding(
                        //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "วันที่เริ่มต้นการลา ",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.all(8.0),
                                  //   child: Text(
                                  //     '${date.day}/${date.month}/${date.year}',
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(fontSize: 15, color: Colors.black),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '${widget.Empleaves.startdate.day}'
                                    '/${widget.Empleaves.startdate.month}'
                                    '/${widget.Empleaves.startdate.year}',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              ),
                            ]),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(60.0),
                                // topLeft: Radius.circular(60.0),
                                // bottomLeft: Radius.circular(36),
                                // bottomRight: Radius.circular(36))
                                )),
                        // color: Colors.cyan,
                        // child: Padding(
                        //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "เวลาเริ่มต้นการลา ",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.all(8.0),
                                  //   child: Text(
                                  //     '${date.day}/${date.month}/${date.year}',
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(fontSize: 15, color: Colors.black),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '${widget.Empleaves.startdate.hour}'
                                    ':${widget.Empleaves.startdate.minute} น.',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              ),
                            ]),
                      )),

                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(60.0),
                                // topLeft: Radius.circular(60.0),
                                // bottomLeft: Radius.circular(36),
                                // bottomRight: Radius.circular(36))
                                )),
                        // color: Colors.cyan,
                        // child: Padding(
                        //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "วันสิ้นสุดการลา ",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.all(8.0),
                                  //   child: Text(
                                  //     '${date.day}/${date.month}/${date.year}',
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(fontSize: 15, color: Colors.black),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '${widget.Empleaves.enddate.day}'
                                    '/${widget.Empleaves.enddate.month}'
                                    '/${widget.Empleaves.enddate.year}',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              ),
                            ]),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(60.0),
                                // topLeft: Radius.circular(60.0),
                                // bottomLeft: Radius.circular(36),
                                // bottomRight: Radius.circular(36))
                                )),
                        // color: Colors.cyan,
                        // child: Padding(
                        //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "เวลาสิ้นสุดการลา ",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.all(8.0),
                                  //   child: Text(
                                  //     '${date.day}/${date.month}/${date.year}',
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(fontSize: 15, color: Colors.black),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '${widget.Empleaves.enddate.hour}'
                                    ':${widget.Empleaves.enddate.minute} น.',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              ),
                            ]),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(60.0),
                                // topLeft: Radius.circular(60.0),
                                // bottomLeft: Radius.circular(36),
                                // bottomRight: Radius.circular(36))
                                )),
                        // color: Colors.cyan,
                        // child: Padding(
                        //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "หมายเหตุ ",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.all(8.0),
                                  //   child: Text(
                                  //     '${date.day}/${date.month}/${date.year}',
                                  //     textAlign: TextAlign.center,
                                  //     style: TextStyle(fontSize: 15, color: Colors.black),
                                  //   ),
                                  // ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '${widget.Empleaves.comment}' == 'null'
                                        ? ""
                                        : '${widget.Empleaves.comment}',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              ),
                            ]),
                      )),
 Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey[300],
                            borderRadius: BorderRadius.only(
                                // topRight: Radius.circular(60.0),
                                // topLeft: Radius.circular(60.0),
                                // bottomLeft: Radius.circular(36),
                                // bottomRight: Radius.circular(36))
                                )),
                        // color: Colors.cyan,
                        // child: Padding(
                        //   padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    "สถานะคำร้อง ",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                 
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '${widget.Empleaves.status}' ,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ],
                              ),
                            ]),
                      )),
                  SizedBox(height: 30),

                  SizedBox(height: 30),
                  Container(
                      // margin: EdgeInsets.only(top: 280),
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                          // BorderRadius: new BorderRadius.circular(30.0),
                          child: Text('ลบ', style: TextStyle(fontSize: 18)),
                          //height: 60,
                          // color: iBlueColor,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text('ยืนยัน'),
                                    content: Text('ยืนยันการลบการลา'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('ไม่ใช่')),
                                      TextButton(
                                        child: Text('ใช่'),
                                        onPressed: () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            formKey.currentState!.save();
                                          }
                                          var services = EmpleaveServices();
                                          var controllers = EmpleaveController(
                                                  services)
                                              .deleteEmpleave(
                                                  widget.Empleaves.empcode,
                                                  widget.Empleaves.leavetype,
                                                  widget.Empleaves.startdate,
                                                  widget.Empleaves.enddate);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      profile()));
                                        },
                                        style: ElevatedButton.styleFrom(
                                          //primary: iBlueColor,
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      )
                                    ]);
                              },
                            );
                          }))
                ]))));
  }
}
