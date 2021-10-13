
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Screen/Thesis/calendar.dart';
import 'package:first_app/Screen/Thesis/clock.dart';
import 'package:first_app/Screen/Thesis/leave.dart';
import 'package:first_app/Screen/register.dart';
import 'package:first_app/model/emp_leave.dart';
import 'package:first_app/model/event_form_model.dart';
import 'package:first_app/model/my_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screen/Thesis/Deligate.dart';
import 'Screen/Thesis/Approve.dart';
import 'Screen/Thesis/profile_screen.dart';
import 'Screen/login.dart';
import 'model/Empleavelist_form_model.dart';


// void main() {
//   runApp(MyApp());
// }
// Future <void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp( MyApp());
// }

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('App error please contact admin');
          }

          if (snapshot.connectionState == ConnectionState.done) {
            return MyApp();
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> firebase =
      Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: [
      ChangeNotifierProvider(
        create: (context) => EmpleavelistFormmodel()),
        ChangeNotifierProvider(
        create: (context) => MyThemeModel()),
        
         ChangeNotifierProvider(
        create: (context) => EventFormModel()),
        ],
    
      
      child: MaterialApp(
      title: "My App",
       theme: ThemeData
       (
         primarySwatch: Colors.amber,),
      
        home:MainPage()
        ),
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
  final screens = [deligate(),leave(),Approve(),clock(),Calendar()];
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
        label:'Calendar',
        backgroundColor: Colors.blue,
      )
      ],
     
      
      ),
       
  
     
  
  );
}


