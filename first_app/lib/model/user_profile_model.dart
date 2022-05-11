import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile{
  int empcode;
  String email;
  String firstName;
  String lastName;
  String password;
  String position;
  int roleID;
  String roleName;
  String tel;
  UserProfile(this.empcode,this.email,this.firstName,this.lastName,this.password,this.position
  ,this.roleID,this.roleName,this.tel);

  factory UserProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserProfile(
      json['cid'] as int,
      json['email'] as String,
      json['firstName'] as String,
   
      json['lastName'] as String,
      json['password'] as String,
      json['position'] as String,
      json['roleID'] as int,
      json['roleName'] as String,
      json['tel'] as String,
    );
  }
}

class SingleUser {
  final UserProfile user;
  SingleUser(this.user);

  factory SingleUser.fromJson(QuerySnapshot s) {
    var user = s.docs.map((DocumentSnapshot ds) {
      return UserProfile.fromJson(ds.data() as Map<String, dynamic>);
    });
    return SingleUser(user.first);
  }
}