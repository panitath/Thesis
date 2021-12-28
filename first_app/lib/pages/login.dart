import 'package:first_app/controller/auth_controller.dart';
import 'package:first_app/pages/bottom_nav_page.dart';
import 'package:first_app/pages/profile_page.dart';
import 'package:first_app/widget/login_form.dart';
import 'package:first_app/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/constants/color_constant.dart';
import 'package:first_app/model/resule_model.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/services/auth_service.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'resetpass_page.dart';
import 'signup_page.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final AuthService _authService = AuthService();

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController Email = TextEditingController();
  TextEditingController Password = TextEditingController();
  UserProfileProvider _profile = UserProfileProvider();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final auth = FirebaseAuth.instance;
  bool isLoading = false;
  late int num = 0;
  var service = AuthService();
  var controller;
  _LogInScreenState() {
    controller = AuthController(service);
  }

  gotoHomePage(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavScreen(),
      ),
    );
  }

  void _loadProfile(String email) async{
    final SharedPreferences prefs = await _prefs;
    var newProfile = await controller.GetUserInfo(email);
    setState(()  {
      _profile = newProfile;
      prefs.setString('id_card', _profile.cid);
      print('id_card:${_profile.cid}');
    });
  }
  Widget get body => isLoading
      ? CircularProgressIndicator()
      : Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                iGreenColor,
                iGreenColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        "GHB Time Manangement",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // Row(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         Navigator.push(
                      //           context,
                      //           MaterialPageRoute(
                      //             builder: (context) => SignUpScreen(),
                      //           ),
                      //         );
                      //       },
                      //       child: Text(
                      //         "ผู้ใช้งานใหม่? กดลงทะเบียนตรงนี้",
                      //         style: TextStyle(
                      //           color: Colors.amber[300],
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.w700,
                      //         ),
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Consumer<UserProfileProvider>(builder: (context, form, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            LogInForm(Email, Password),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ResetPasswordScreen()),
                                );
                              },
                              child: Text(
                                'ลืมรหัสผ่าน?',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 14,
                                  decoration: TextDecoration.underline,
                                  decorationThickness: 1,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (Email.text.length == 0) {
                                  _showDialog(context, 'กรุณาระบุอีเมล์');
                                } else if (Password.text.length == 0) {
                                  _showDialog(context, 'กรุณาระบุรหัสผ่าน');
                                } else {
                                  Result result = await controller.SignIn(Email.text, Password.text);
                                  if (result.result) {
                                    _loadProfile(Email.text);
                                    //print('data:${_profile.firstName}');
                                    context.read<UserProfileProvider>().profile = _profile;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            profile(),
                                      )
                                    );
                                  } else {
                                    _showDialog(context,
                                        result.msg);
                                  }
                                }
                              },
                              child: PrimaryButton(
                                  buttonText: 'เข้าสู่ระบบ',
                                  buttonColor: iGreenColor),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    }),
                  ))
            ],
          ),
        );

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: body,
        )
      ),
    );
  }
}

void _showDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('แจ้งเตือน'),
        content: Text(text),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ตกลง'))
        ],
      );
    },
  );
}