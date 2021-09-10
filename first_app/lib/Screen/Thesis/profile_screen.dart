import 'package:first_app/Screen/Thesis/profile.dart';

import 'package:flutter/material.dart';

class profile_screen extends StatelessWidget {
  const profile_screen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Profile"),)
        ,body: profile(),
    );
  }
}