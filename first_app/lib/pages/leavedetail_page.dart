
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/pages/leavelist_page.dart';
import 'package:flutter/material.dart';

class LeaveDetail extends StatelessWidget {
  final Empleave leave;
  const LeaveDetail({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายละเอียดการลา")),
      body: Container(
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
                          Text("ประเภทลา", style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(leave.leavetype.toString(),
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ]),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("วันที่เริ่มต้นลา",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(leave.startdate.toString(),
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ]),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("วันที่สิ้นสุดลา",
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(leave.enddate.toString(),
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ]),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text("หมายเหตุ", style: TextStyle(fontSize: 15)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(leave.comment.toString(),
                              style: TextStyle(fontSize: 15)),
                        ],
                      ),
                    ]),
              ),
            ), SizedBox(
                width: 150,
                height: 50),
            SizedBox(
                 width: 350,
                    height: 50,
                child: ElevatedButton(
                    child: Text("ยกเลิกการลา"),
                    onPressed: () {
                      //async{

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Leave_list();
                      }));
                    }))
            // Padding(
            //   padding: const EdgeInsets.all(15.0),
            //   child: Text(leave.leaveid.toString()),
            // ),Text(leave.startdate.toString()),
          ],
        ),
      ),
    );
  }
}
