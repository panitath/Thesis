
import 'package:first_app/controller/authen_controller.dart';
import 'package:first_app/pages/profilem_page.dart';
import 'package:first_app/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'profile_page.dart';
import 'report_attendace_page.dart';
import 'report_delegate_page.dart';
import 'report_leave_page.dart';
import 'report_leavedetail_page .dart';
import 'report_task_page.dart';

class report extends StatefulWidget {
  const report({Key? key}) : super(key: key);

  @override
  _reportState createState() => _reportState();
}
var eAuthenServices = EAuthenServices();
 var employeeController = EAuthenController(eAuthenServices);

class _reportState extends State<report> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        body: ListView(children: <Widget>[
      
          Container(
            //SizedBox(height: 25.0),
            height: size.height * .10,
             
            child: Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[  IconButton(
                    icon: Icon(Icons.wysiwyg  ),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  Text('รายงาน                          ',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0)),
                          
                 IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {


                        Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return profile();
                                          }));
                    },
                  ),
                
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Color(0xFF21BFBD),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(200))),
          ),
          SizedBox(
            height: 40,
            child: const DecoratedBox(
              decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                     // topLeft: Radius.circular(1000),
                       topRight: Radius.circular(1000),
                     // bottomRight: Radius.circular(200)
                      )),
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
              
          icon: "assets/images/deligate.svg",
               text: "รายงานการมอบหมายปฏิบัติหน้าที่แทน",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DelegateDetail();
                }));
              },
            ),
          ),
        
          Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
             icon: "assets/images/calendartask.svg",
               text: "รายงานการทำงาน",
           
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TaskDetail();
                }));
              },
            ),
          ),
            Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
             icon: "assets/images/calendar.svg",
               text: "รายงานการลา",
           
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return leavedetail_report();
                }));
              },
            ),
          ),

            Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
             icon: "assets/images/clock.svg",
               text: "รายงานเวลาปฏิบัติงาน",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ClockDetail();
                }));
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: const DecoratedBox(
              decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                     // topLeft: Radius.circular(1000),
                       bottomLeft: Radius.circular(1000),
                     // bottomRight: Radius.circular(200)
                      )),
            ),
          ),
            
        ])
        //bottomNavigationBar: BottomNavigation(),
        );
  }
}

class profilemenu extends StatelessWidget {
  const profilemenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
            primary: Colors.grey[300],
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        // textStyle:
        //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 30,
              color: Colors.black87,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style:   TextStyle(
                fontSize: 18, fontWeight: FontWeight.w700,
                
              )
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
