import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/constants/font_sonstant.dart';
import 'package:first_app/controller/empleave_controller.dart';
import 'package:first_app/model/task_provider.dart';
import 'package:first_app/model/attendance_provider.dart';
import 'package:first_app/model/clock_provider.dart';
import 'package:first_app/model/deligate_provider.dart';
import 'package:first_app/model/employee_provider.dart';
import 'package:first_app/model/event_form_model.dart';
import 'package:first_app/model/my_theme_provider.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/services/empleave_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/authen_controller.dart';
import 'model/Empleave_provider.dart';
import 'pages/delegate_page.dart';
import 'pages/calendar_page.dart';
import 'pages/clock_page.dart';
import 'pages/leave_page.dart';
import 'pages/leavelist_page.dart';
import 'pages/login.dart';
import 'pages/profile_page.dart';
import 'pages/profilem_page.dart';
import 'services/api_service.dart';

// void main() {
//   runApp(MyApp());
// }
// Future <void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp( MyApp());
// }

void main() async {
   

//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(App());
// }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmpleaveProvider()),
        ChangeNotifierProvider(create: (context) => MyThemeModel()),
        ChangeNotifierProvider(create: (context) => EventFormModel()),
        ChangeNotifierProvider(create: (context) => DelegateProvider()),
        ChangeNotifierProvider(create: (context) => ClockProvider()),
        ChangeNotifierProvider(create: (context) => EmployeeProvider()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider()),
       ChangeNotifierProvider(create: (context) => AttendanceProvider()),
        ChangeNotifierProvider(create: (context) => UserProfileProvider()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
      ],
    
    
    child:MyApp(),),);

  // runApp(TodoApp(controller: controller));
}



class MyApp extends StatelessWidget {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
 
  @override
  Widget build(BuildContext context) {
    return 
       MaterialApp(
          title: "My App",
          theme: ThemeData(
            primarySwatch: Palette.kToDark,
             fontFamily: fontRegular,
          ),

          home:MainPage(),
          // initialRoute: '/1',
          // routes: <String, WidgetBuilder>{
          //   '/1': (context) =>profile(),
          //   '/2': (context) => leave(),
          //   // '/3': (context) => ThridPage(),
          //   // '/4': (context) => FourthPage(),
          //   // '/5': (context) => fifthPage(),
          //   // '/6': (context) => SixthPage(),
          //   // '/7': (context) => SeventhPage(),
          //   // '/8': (context) => EighthPage()
          // } //home: MainPage(),
          
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  

  @override
  _MainPageState createState() => _MainPageState();
}
 

@override
class _MainPageState extends State<MainPage> {
  int index = 0;
  final screens = [profile(),delegate(), leave(), clock(), Calendar()];//[LogInScreen()
 

  
  Widget build(BuildContext context) {
    return Scaffold(
body: buildPages(),
//bottomNavigationBar: buildBottomNavigation(),
);
}

Widget buildPages(){
    var eAuthenServices = EAuthenServices();
 var employeeController = EAuthenController(eAuthenServices);

   var eEmpServices = EmpleaveServices();
 var leaveController = EmpleaveController(eEmpServices);
  
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
  default: return  LogInScreen(employeeController,leaveController);
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
//         body: screens[currentIndex],
//         bottomNavigationBar: BottomNavigationBar(
//           type: BottomNavigationBarType.fixed,
//           currentIndex: currentIndex,
//           onTap: (index) => setState(() => currentIndex = index),
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               label: 'HOME',
//               backgroundColor: Colors.blue,
//             ),
            
//             BottomNavigationBarItem(
//               icon: Icon(Icons.manage_accounts),
//               label: 'มอบหมายปฏิบัติหน้าที่แทน',
//               backgroundColor: Colors.blue,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_today_rounded),
//               label: 'การลาหยุด',
//               backgroundColor: Colors.blue,
//             ),
//             // BottomNavigationBarItem(
//             //   icon: Icon(Icons.list_outlined),
//             //   label: 'รายการลาหยุด',
//             //   backgroundColor: Colors.blue,
//             // ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.timer),
//               label: 'บันทึกเวลาทำงาน',
//               backgroundColor: Colors.blue,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.account_box),
//               label: 'ปฏิทิน',
//               backgroundColor: Colors.blue,
//             )
//           ],
//         ),
//       );
// }
class Palette { 
  static const MaterialColor kToDark = const MaterialColor( 
    0xFFFFAD33, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    const <int, Color>{ 
      50: const Color(0xffce5641 ),//10% 
      100: const Color(0xffb74c3a),//20% 
      200: const Color(0xffa04332),//30% 
      300: const Color(0xff89392b),//40% 
      400: const Color(0xff733024),//50% 
      500: const Color(0xff5c261d),//60% 
      600: const Color(0xff451c16),//70% 
      700: const Color(0xff2e130e),//80% 
      800: const Color(0xff170907),//90% 
      900: const Color(0xff000000),//100% 
    }, 
  ); 
} // you can d