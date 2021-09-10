import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class welcomescreen extends StatelessWidget {

final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome Sir"),),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(children: [
        
        ],),
      ), 
    ),
    
     
      
    );
  }
}