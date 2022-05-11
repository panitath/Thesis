// import 'package:first_app/controller/authen_controller.dart';
// import 'package:first_app/model/authen_model.dart';
// import 'package:first_app/model/resule_model.dart';
// import 'package:flutter/material.dart';

// class LogInScreen extends StatefulWidget {
//   final EAuthenController employeeController;

//   LogInScreen(this.employeeController);

//   @override
//   _LogInCustomState createState() => _LogInCustomState();
// }

// class _LogInCustomState extends State<LogInScreen> {
//   final _formkey = GlobalKey<FormState>();
//   List<String> items = ['@gmail.com', '@ghb.co.th', '@hotmail.com'];
//   AuthenModel? model;
//   Result? result;
//   String? _chosenValue;
//   String? _username;
//   String? _password;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     widget.employeeController.onSync
//         .listen((bool syncState) => setState(() => isLoading = syncState));
//   }

//   void _EmployeeAuthentication() async {
//     var response =
//         await widget.employeeController.authentication(_username!, _password!);
//     setState(() {
//       model = response;
//     });
//     if (model!.status == true) {
//       Navigator.pushNamed(context, '/home');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text(model!.message.toString()),
//         duration: Duration(seconds: 5),
//       ));
//     }
//   }


//   Widget get body => isLoading
//       ? CircularProgressIndicator(
//           valueColor: new AlwaysStoppedAnimation<Color>(gOrangeColor),
//         )
//       : Form(
//           key: _formkey,
//           child: Padding(
//             padding: EdgeInsets.all(20.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           border: UnderlineInputBorder(),
//                           labelText: 'อีเมล์',
//                           labelStyle: TextStyle(
//                             color: gBlackColor,
//                           ),
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: gOrangeColor),
//                           ),
//                           focusedBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: gOrangeColor),
//                           ),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'กรุณาระบุอีเมล์';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _username = value;
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: DropdownButton<String>(
//                         isExpanded: true,
//                         focusColor: Colors.orange,
//                         value: _chosenValue,
//                         elevation: 5,
//                         style: TextStyle(color: Colors.orange),
//                         iconEnabledColor: Colors.black,
//                         items:
//                             items.map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(
//                               value,
//                               style: TextStyle(
//                                 fontSize: 18,
//                               ),
//                             ),
//                           );
//                         }).toList(),
//                         hint: Text(
//                           "domain",
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w500),
//                         ),
//                         onChanged: (String? value) {
//                           setState(() {
//                             _chosenValue = value;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 TextFormField(
//                   decoration: InputDecoration(
//                     border: UnderlineInputBorder(),
//                     labelText: 'รหัสผ่าน',
//                     labelStyle: TextStyle(
//                       color: gBlackColor,
//                     ),
//                     enabledBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: gOrangeColor),
//                     ),
//                     focusedBorder: UnderlineInputBorder(
//                       borderSide: BorderSide(color: gOrangeColor),
//                     ),
//                   ),
//                   obscureText: true,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'กรุณาระบุรหัสผ่าน';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _password = value;
//                   },
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: EdgeInsets.only(top: 5),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       InkWell(
//                         child: Text(
//                           'ลืมรหัสผ่าน?',
//                           style: TextStyle(color: gOrangeColor),
//                           textAlign: TextAlign.right,
//                         ),
//                         onTap: () {
//                           Navigator.pushNamed(context, '/forgot');
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.only(top: 20),
//                   width: MediaQuery.of(context).size.width,
//                   height: 60,
//                   child: FlatButton(
//                     shape: new RoundedRectangleBorder(
//                       borderRadius: new BorderRadius.circular(30.0),
//                     ),
//                     color: gOrangeColor,
//                     onPressed: () async {
//                       if (_formkey.currentState!.validate()) {
//                         _formkey.currentState!.save();
//                         print(_chosenValue);
//                         if (_chosenValue == "@ghb.co.th") {
//                           _EmployeeAuthentication();
//                         } else {
//                           _CustomerAuthentication();
//                         }
//                         //Navigator.pushNamed(context, '/register');
//                       }
//                       //Navigator.pushNamed(context, '/home');
//                     },
//                     child: Text('เข้าสู่ระบบ',
//                         style: TextStyle(
//                             fontFamily: fontRegular,
//                             fontSize: 20,
//                             color: gWhiteColor)),
//                   ),
//                 ),
//                 Center(
//                     child: Container(
//                         margin: EdgeInsets.only(top: 10),
//                         child: Text(
//                           'หรือ',
//                           style: TextStyle(color: gGreyColor),
//                         ))),
//                 Container(
//                   margin: EdgeInsets.only(top: 20),
//                   width: MediaQuery.of(context).size.width,
//                   height: 60,
//                   child: FlatButton(
//                     shape: new RoundedRectangleBorder(
//                         //borderRadius: new BorderRadius.circular(30.0)
//                         side: BorderSide(
//                           color: gOrangeColor,
//                         ),
//                         borderRadius: BorderRadius.circular(30)),
//                     color: gWhiteColor,
//                     onPressed: () async {},
//                     child: Text('ลงทะเบียน',
//                         style: TextStyle(
//                             fontFamily: fontRegular,
//                             fontSize: 20,
//                             color: gOrangeColor)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'เข้าสู่ระบบ',
//           style: TextStyle(
//               fontFamily: fontRegular,
//               fontSize: 20,
//               fontWeight: FontWeight.w700,
//               color: gWhiteColor),
//         ),
//       ),
//       body: Center(child: body),
//     );
//   }
// }
