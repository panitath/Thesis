import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:first_app/pages/calendar_page.dart';
import 'package:first_app/pages/clock_page.dart';
import 'package:first_app/pages/leave_page.dart';
import 'package:first_app/pages/leavelist_page.dart';
import 'package:first_app/pages/login.dart';
import 'package:first_app/pages/profile_page.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({ Key? key }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  final inactiveColor = Colors.grey;
 int index = 0;
  Widget build(BuildContext context) {
  

   return Scaffold(
   body: buildPages(),
    bottomNavigationBar: buildBottomNavigation(),);
   

}

Widget buildPages(){
switch (index){
   case 1:
   return leave();
  case 2:
  return Leave_list();
   case 3:
  return clock();
   case 4:
  return Calendar();
  case 0:
  default: return profile();
}

}

 Widget buildBottomNavigation(){
final inactiveColor = Colors.grey;

   return BottomNavyBar(
     selectedIndex: index,
     onItemSelected: (index) => setState(()=> this.index = index),
     items: <BottomNavyBarItem>[
       BottomNavyBarItem( icon: Icon(Icons.home),
       title: Text('HOME'),
       textAlign: TextAlign.center,
       inactiveColor:inactiveColor,
       activeColor: Colors.green ),

 BottomNavyBarItem( icon: Icon(Icons.perm_contact_calendar_rounded),
       title: Text('การลาหยุด'),
        textAlign: TextAlign.center,
       inactiveColor:inactiveColor,
       activeColor: Colors.red),

 BottomNavyBarItem( icon: Icon(Icons.featured_play_list_rounded ),
       title: Text('รายการลาหยุด'),
        textAlign: TextAlign.center,
       inactiveColor:inactiveColor,
       activeColor: Colors.green),
 BottomNavyBarItem( icon: Icon(Icons.timer),
       title: Text('บันทึกเวลาทำงาน'),
        textAlign: TextAlign.center,
       inactiveColor:inactiveColor,
       activeColor: Colors.red ),
 BottomNavyBarItem( icon: Icon(Icons.calendar_today_rounded),
       title: Text('ปฏิทิน'),
        textAlign: TextAlign.center,
       inactiveColor:inactiveColor,
       activeColor: Colors.green ),

     ],
   );
 }

      
}