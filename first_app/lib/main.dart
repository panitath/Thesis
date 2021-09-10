
import 'package:flutter/material.dart';

import 'Screen/Thesis/Deligate.dart';
import 'Screen/Thesis/approve.dart';
import 'Screen/Thesis/profile_screen.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: "My App",
     theme: ThemeData
     (
       primarySwatch: Colors.amber,),
  
     
      home:MainPage()
      );
   
  }
  }
class MainPage extends StatefulWidget {
  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
    int currentIndex = 4;
  final screens = [deligate(),leave(),approve(),clock(),profile_screen()];
  @override
  Widget build(BuildContext context) => Scaffold(
       
body: screens[currentIndex],
   bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          
         BottomNavigationBarItem(icon: Icon(Icons.manage_accounts),
        label:'Deligate',
        backgroundColor: Colors.blue,
      ),
        BottomNavigationBarItem(icon: Icon(Icons.calendar_today_rounded),
        label:'Leave',
        backgroundColor: Colors.blue,
      ),
      BottomNavigationBarItem(icon: Icon(Icons.list_outlined),
        label:'Approve',
        backgroundColor: Colors.blue,
      ),
       BottomNavigationBarItem(icon: Icon(Icons.timer),
        label:'Clockin-out',
        backgroundColor: Colors.blue,
      ),
       BottomNavigationBarItem(icon: Icon(Icons.account_box),
        label:'Profile',
        backgroundColor: Colors.blue,
      ),
      ],
     
      
      ),
       
  
     
  
  );
}

clock() {
}

leave() {
}
