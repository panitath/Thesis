import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/user_class_model.dart';

abstract class AUserService {
  Future<List<User>> getUsers();
  Future<void> addUser(User items);
}

class UserServices extends AUserService {
  CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_user');

  @override
  Future<List<User>> getUsers() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('icovid_user')
        .orderBy('createDate', descending: false)
        .get();

    AllUsers users = AllUsers.fromSnapshot(snapshot);
    return users.users;
  }

  @override
  Future<void> addUser(User items) {
    print('items.email:${items.email}');
    return _ref.add({
      'email': items.email,
      'firstName': items.firstName,
      'lastName': items.lastName,
      'password': items.password,
      'position': items.position,
      'roleID': items.roleID,
      'roleName': items.roleName,
      'hospitalID': items.hospitalID,
      'hospitalName': items.hospitalName,
      'createDate':DateTime.now(),
      'tel':'',
      'cid':0
    });
    //.then((value) => print('Booking Added'))
    //.catchError((error) => print("Failed to add Booking: $error"));
  }
}