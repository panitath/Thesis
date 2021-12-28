

import 'package:flutter/material.dart';

import 'profile_page.dart';

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