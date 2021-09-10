import 'package:first_app/Screen/login.dart';
import 'package:first_app/Screen/register.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register/Login"),
      ),
    body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(children: [
        Image.asset("assets/images/logo.jpg"),
          SizedBox(
          width: double.infinity,
            child: ElevatedButton.icon(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return RegisterScreen();
                }));
            },
             icon: Icon(Icons.add), 
             label: Text("Create Account",style: TextStyle(fontSize: 20),))
          ),SizedBox(
           width: double.infinity,
            child: ElevatedButton.icon(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return LoginSreen();
                }));
            },
             icon: Icon(Icons.login), 
             label: Text("Login",style: TextStyle(fontSize: 20),))
          )
        ],),
      ),
    ),);
  }
}
