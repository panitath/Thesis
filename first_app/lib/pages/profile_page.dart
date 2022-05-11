import 'package:first_app/controller/authen_controller.dart';
import 'package:first_app/controller/empleave_controller.dart';
import 'package:first_app/pages/approve_page.dart';
import 'package:first_app/pages/attendance_page.dart';
import 'package:first_app/pages/calendar_page.dart';
import 'package:first_app/pages/clock_page.dart';
import 'package:first_app/pages/delegate_page.dart';
import 'package:first_app/pages/leave_page.dart';
import 'package:first_app/pages/leavelist_page.dart';
import 'package:first_app/pages/login.dart';
import 'package:first_app/pages/manager_page.dart';
import 'package:first_app/widget/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'report_page.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}
 late final EAuthenController authenController;
  late final EmpleaveController empleaveController;
class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0xFF21BFBD),
        body: ListView(children: <Widget>[
          // Container(
          //   //color: Color(0xFF21BFBD),0xFFFFF9800
          //  color: Color(0xFFFFF9800),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: <Widget>[
          //         IconButton(
          //           icon: Icon(Icons.arrow_back_ios),
          //           color: Colors.white,
          //           onPressed: () {},
          //         ),
          //         // Container(
          //         //     width: 125.0,
          //         //     child: Row(
          //         //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         //       children: <Widget>[
          //         //         IconButton(
          //         //           icon: Icon(Icons.filter_list),
          //         //           color: Colors.white,
          //         //           onPressed: () {},
          //         //         ),
          //         //         IconButton(
          //         //           icon: Icon(Icons.menu),
          //         //           color: Colors.white,
          //         //           onPressed: () {},
          //         //         )
          //         //       ],
          //         //     ))
          //       ],
          //     ),
            
          // ),
          Container(
            //SizedBox(height: 25.0),
            height: size.height * .10,
             
            child: Padding(
              padding: EdgeInsets.only(left: 40.0),
              child: Row(
                children: <Widget>[  IconButton(
                    icon: Icon(Icons.home),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                  Text('HOME                            ',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0)),
                          
                 IconButton(
                    icon: Icon(Icons.logout_sharp),
                    color: Colors.white,
                      onPressed: () {


                        Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return LogInScreen(authenController,empleaveController);
                                          }));
                    },
                  ),
                  SizedBox(width: 10.0),
                  Text('',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontSize: 25.0))
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
               text: "มอบหมายปฏิบัติหน้าที่แทน",
              //text: "รายงานประวัติการลา",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return delegate();
                }));
              },
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
             icon: "assets/images/calendar.svg",
               text: "การลาหยุด",
             // text: "รายงานประวัติการรับรองการปฏิบัติงาน",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return leave();
                }));
              },
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
          icon: "assets/images/leavelist1.svg",
              text: "รายการลาหยุด",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Leave_list();
                }));
              },
            ),
          ),
          Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
          icon: "assets/images/clock.svg",
              text: "เวลาปฏิบัติงาน",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return clock();
                }));
              },
            ),
          ),
          // Container(
          //   color: Color(0xFFFFFFFF),
          //   child: profilemenu(
          //   icon: "assets/images/attendance1.svg",
          //     text: "รับรองเวลาปฏิบัติงาน",
          //     press: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) {
          //         return attendance();
          //       }));
          //     },
          //   ),
          // ),
        

            Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
              icon: "assets/images/calendartask.svg",
              text: "ปฏิทิน",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Calendar();
                }));
              },
            ),
          ), 
            
            Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
              icon: "assets/images/manager1.svg",
              text: "ผู้บังคับบัญชา",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ManagerPage();
                }));
              },
            ),
          ),  
           Container(
            color: Color(0xFFFFFFFF),
            child: profilemenu(
              icon: "assets/images/Report.svg",
              text: "รายงาน",
              press: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return report();
                }
                ));
              },
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
