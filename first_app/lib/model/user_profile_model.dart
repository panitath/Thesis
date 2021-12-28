import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile{
  String cid;
  String email;
  String firstName;
  int hospitalID;
  String hospitalName;
  String lastName;
  String password;
  String position;
  int roleID;
  String roleName;
  String tel;
  UserProfile(this.cid,this.email,this.firstName,this.hospitalID,this.hospitalName,this.lastName,this.password,this.position
  ,this.roleID,this.roleName,this.tel);

  factory UserProfile.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserProfile(
      json['cid'] as String,
      json['email'] as String,
      json['firstName'] as String,
      json['hospitalID'] as int,
      json['hospitalName'] as String,
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