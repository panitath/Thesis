// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:first_app/constants/color_constant.dart';
// import 'package:first_app/controller/auth_controller.dart';
// import 'package:first_app/model/resule_model.dart';
// import 'package:first_app/pages/login.dart';
// import 'package:first_app/services/auth_service.dart';
// import 'package:first_app/widget/checkbox.dart';
// import 'package:first_app/widget/primary_button.dart';
// import 'package:first_app/widget/signup_form.dart';
// import 'package:flutter/material.dart';

// FirebaseFirestore _firestore = FirebaseFirestore.instance;

// class SignUpScreen extends StatefulWidget {
//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final _formKey = GlobalKey<FormState>();

//   TextEditingController _firstName = TextEditingController();
//   TextEditingController _lastName = TextEditingController();
//   TextEditingController _email = TextEditingController();
//   TextEditingController _cid = TextEditingController();
//   TextEditingController _phon = TextEditingController();
//   TextEditingController _password = TextEditingController();
//   TextEditingController _Confirpassword = TextEditingController();
//   var service = AuthService();
//   var controller;
//   _SignUpScreenState() {
//     controller = AuthController(service);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: iBlueColor,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 30, right: 30),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 "ลงทะเบียนผู้ใช้งาน",
//                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               Row(
//                 children: [
//                   Text(
//                     '',
//                     style: TextStyle(fontSize: 20),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SignUpForm(_formKey, _firstName, _lastName, _email, _cid, _phon,
//                   _password, _Confirpassword),
//               SizedBox(
//                 height: 20,
//               ),
//               CheckBox('ผู้ใช้ยินยอมให้เก็บข้อมูล'),
//               SizedBox(
//                 height: 15,
//               ),
//               CheckBox('ผู้ใช้งานมีอายุตั้งเเต่ 18 ปีขึ้นไป'),
//               SizedBox(
//                 height: 15,
//               ),
//               GestureDetector(
//                 onTap: () async {
//                   //CheckValueSignUp(_formKey, context, password, _Confirpassword);
//                   if (_formKey.currentState!.validate()) {
//                     _formKey.currentState!.save();
//                     if (_Confirpassword.text == _password.text) {
//                       try {
//                         Result result = await controller.RegisLogin(_firstName.text, _lastName.text,
//                             _email.text, _cid.text, _phon.text, _password.text);
//                         if(result.result){
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 content: Text(
//                                     'ลงทะเบียนเรียบร้อยเเล้ว ให้ log in อีกครั้งเพื่อเข้าใช้งาน')),
//                           );
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LogInScreen()),
//                           );
//                         }else{
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                                 content:
//                                     Text(result.msg)),
//                           );
//                         }
                        
//                       } catch (e) {
//                         print("ขออภัยไม่สามารถเพิ่มข้อมูลผู้ใช้งานได้กรุณาลองใหม่อีกครั้ง");
//                       }
//                       /*
//                       List<User> listUser = [];
//                       if (context.read<UserProvider>().userList != null) {
//                         listUser = context.read<UserProvider>().userList;
//                       }
                      
//                       listUser.add(User(
//                           id_card: int.tryParse(_cid.text),
//                           first_name: _firstName.text,
//                           last_name: _lastName.text,
//                           tel: _phon.text,
//                           email: _email.text,
//                           password: _password.text,
//                           position: 'ผู้ใช้งานทั่วไป',
//                           roleId: 2,
//                           roleName: 'ผู้ใช้งานทั่วไป'));
//                       context.read<UserProvider>().userList = listUser;
//                       context.read<UserProvider>().id_card = int.tryParse(_cid.text);
//                       context.read<UserProvider>().first_name = _firstName.text;
//                       context.read<UserProvider>().last_name = _lastName.text;
//                       context.read<UserProvider>().tel = _phon.text;
//                       context.read<UserProvider>().email = _email.text;
//                       context.read<UserProvider>().password = _password.text;
//                       context.read<UserProvider>().position = 'ผู้ใช้งานทั่วไป';
//                       context.read<UserProvider>().roleId = 2;
//                       context.read<UserProvider>().roleName = 'ผู้ใช้งานทั่วไป';
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(
//                             content: Text(
//                                 'ลงทะเบียนเรียบร้อยเเล้ว ให้ log in อีกครั้งเพื่อเข้าใช้งาน')),
//                       );
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => LogInScreen()),
//                       );
//                       */
//                     } else {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                             content:
//                                 Text('รหัสผ่านและยืนยันรหัสผ่านไม่ตรงกัน')),
//                       );
//                     }
//                   }
//                 },
//                 child: PrimaryButton(
//                   buttonText: 'ยืนยันการลงทะเบียน',
//                   buttonColor: iBlueColor,
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // RegisLogin(String firstname, String lastname, String email, String cid,
// //     String tel, String password) async {
// //   try {
// //     UserCredential userCredential = await FirebaseAuth.instance
// //         .createUserWithEmailAndPassword(email: email, password: password);
// //   } on FirebaseAuthException catch (e) {
// //     if (e.code == 'weak-password') {
// //       print('The password provided is too weak.');
// //     } else if (e.code == 'email-already-in-use') {
// //       print('The account already exists for that email.');
// //     }
// //   } catch (e) {
// //     print(e);
// //   }

// //   await _firestore
// //       .collection("icovid_user")
// //       .add({
// //         'firstname': firstname,
// //         'lastname': lastname,
// //         'email': email,
// //         'cid': cid,
// //         'tel': tel,
// //         'password': password,
// //         'roleID': 2,
// //       })
// //       .then((value) => print("User Add"))
// //       .catchError((error) => print("Failed to add user: $error"));
// // }

// void CheckValueSignUp(_formKey, context, TextEditingController password,
//     TextEditingController _Confirpassword) {
//   if (_formKey.currentState!.validate()) {
//     if (_Confirpassword.text == password.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text(
//                 'ลงทะเบียนเรียบร้อยเเล้ว ให้ log in อีกครั้งเพื่อเข้าใช้งาน')),
//       );
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => LogInScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Email หรือ รหัสผ่านไม่ถูกต้อง')),
//       );
//     }
//   }
// }

// bool isNumeric(String value) {
//   if (value == null || value.isEmpty) {
//     return false;
//   }
//   final number = num.tryParse(value);
//   if (number == null) {
//     return false;
//   }
//   return true;
// }