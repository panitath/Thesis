import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/Screen/Thesis/calendar.dart';
import 'package:first_app/Screen/Thesis/clock.dart';
import 'package:first_app/Screen/Thesis/leave.dart';
import 'package:first_app/Screen/Thesis/leavelist.dart';
import 'package:first_app/Screen/Thesis/todo.dart';
import 'package:first_app/controller/todo.dart';
import 'package:first_app/model/event_form_model.dart';
import 'package:first_app/model/my_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screen/Thesis/Deligate.dart';
import 'model/Empleavelist_form_model.dart';
import 'services/services.dart';

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

  var services = FirebaseServices();
  var controller = TodoController(services);
  runApp(App(controller: controller));

  // runApp(TodoApp(controller: controller));
}

class TodoApp extends StatelessWidget {
  final TodoController controller;
  TodoApp({required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoPage(
        controller: controller,
      ),
    );
  }
}

class App extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
final TodoController controller;
  App({required this.controller});

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
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmpleavelistFormmodel()),
        ChangeNotifierProvider(create: (context) => MyThemeModel()),
        ChangeNotifierProvider(create: (context) => EventFormModel()),
      ],
      child: MaterialApp(
          title: "My App",
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),

          home:MainPage()
          // initialRoute: '/2',
          // routes: <String, WidgetBuilder>{
          //   '/1': (context) => leave(),
          //   '/2': (context) => deligate(),
            // '/3': (context) => ThridPage(),
            // '/4': (context) => FourthPage(),
            // '/5': (context) => fifthPage(),
            // '/6': (context) => SixthPage(),
            // '/7': (context) => SeventhPage(),
            // '/8': (context) => EighthPage()
          // }
          ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final screens = [deligate(), leave(), leave_list(), clock(), Calendar()];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts),
              label: 'มอบหมายปฏิบัติหน้าที่แทน',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_rounded),
              label: 'การลาหยุด',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_outlined),
              label: 'รายการลาหยุด',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'บันทึกเวลาทำงาน',
              backgroundColor: Colors.blue,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'ปฏิทิน',
              backgroundColor: Colors.blue,
            )
          ],
        ),
      );
}
