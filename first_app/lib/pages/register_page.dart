import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app/model/profile.dart';
import 'package:first_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(
    email: ' ',
    password: ' ',
  );

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Erroro"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Create Account"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email", style: TextStyle(fontSize: 20)),
                            TextFormField(
                              validator: MultiValidator([
                                EmailValidator(
                                    errorText: "Please fill format Email"),
                                RequiredValidator(
                                    errorText: "Please fill Email"),
                              ]),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String? email) {
                                profile.email = email!;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Password", style: TextStyle(fontSize: 20)),
                            TextFormField(
                              validator: RequiredValidator(
                                  errorText: "Please fill password"),
                              obscureText: true,
                              onSaved: (String? password) {
                                profile.password = password!;
                              },
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text("Register"),
                                onPressed: () async{
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                  try{
                                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: profile.email, 
                                      password: profile.password).then((value) {
                                      // formKey.currentState!.reset();
                                     Fluttertoast.showToast(
                                    msg: "Success",
                                    gravity: ToastGravity.CENTER);
                                  
                                   Navigator.pushReplacement(context
                                   ,MaterialPageRoute(builder: (context){
                                     return HomeScreen();
                                   }));
                                      });
                                  

                                    }
                                    on FirebaseException
                                catch(e){
                                  // print(e.code);
                                  // print(e.message);
                                  Fluttertoast.showToast(
                                    msg: "pp",
          
                                    gravity: ToastGravity.CENTER);
                                   
                                }

                                   
                                  }
                                },
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
