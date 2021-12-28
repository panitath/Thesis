
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  //final String? id_card;
   String firstName;
   String lastName;
  //final String? tel;
   String email;
   String password;
   String position;
   int roleID;
   String roleName;
   int hospitalID;
   String hospitalName;

  User(
    //this.id_card,
    this.firstName,
    this.lastName,
    //this.tel,
    this.email,
    this.password,
    this.position,
    this.roleID,
    this.roleName,
    this.hospitalID,
    this.hospitalName,
  );

  factory User.fromDs(
    Map<String, Object?> json,
  ) {
    return User(
      json['firstName'] as String,
      json['lastName'] as String,
      json['email'] as String,
      json['password'] as String,
      json['position'] as String,
      json['roleID'] as int,
      json['roleName'] as String,
      json['hospitalID'] as int,
      json['hospitalName'] as String,
    );
  }

}

class AllUsers {
  final List<User> users;
  AllUsers(this.users);

  factory AllUsers.fromSnapshot(QuerySnapshot s) {
    List<User> users = s.docs.map((DocumentSnapshot ds) {
      return User.fromDs(ds.data() as Map<String, dynamic>);
    }).toList();
    return AllUsers(users);
  }
}


//State
