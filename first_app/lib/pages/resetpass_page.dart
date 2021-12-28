import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/constants/color_constant.dart';
import 'package:first_app/pages/login.dart';
import 'package:first_app/widget/primary_button.dart';
import 'package:flutter/material.dart';


TextEditingController Email = TextEditingController();

class ResetPasswordScreen extends StatelessWidget {
  //const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: iBlueColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "ตั้งค่ารหัสผ่านใหม่",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 5,
              ),
              Text("กรุณาระบุอีเมล์"),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextFormField(
                  controller: Email,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    var FirebaseAuth;
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: Email.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('กรุณาไปตรวจสอบ ที่ Email ขอบคุณ')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LogInScreen()),
                    );
                  } on FirebaseAuthException catch (e) {
                    print("error" + e.toString());
                  }

                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                  );
                  */
                },
                child: PrimaryButton(
                  buttonText: "ตกลง",
                  buttonColor: iBlueColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}