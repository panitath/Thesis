import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/model/resule_model.dart';
import 'package:first_app/model/user_profile_model.dart';
import 'package:first_app/model/user_profile_provider.dart';


abstract class AAuthService{
  Future<Result> signIn(String email, String password);
  Future<int> getRoleID(String email, String password);
  Future<Result> regisLogin(String firstname, String lastname, String email, String cid,String tel, String password) ;
  Future<Result> signOut();
  Future<void> addUserInfo(String firstname, String lastname, String email, String cid,String tel, String password);
  Future<UserProfileProvider> getUserInfo(String email);
}

class AuthService extends AAuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _ref = FirebaseFirestore.instance.collection('icovid_user');

  Future<Result> signIn(String email, String password) async {
    Result res = Result(false, '');
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
        res.result = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
          res.result = false;
          res.msg = 'กรุณาระบุรหัสผ่านให้มีความยาว 6 ตัวอักษรขึ้นไป';
        } else if (e.code == 'email-already-in-use') {
          res.result = false;
          res.msg = 'มีอีเมล์นี้ในระบบแล้ว โปรดใช้อีเมล์อื่น';
        }else{
          res.result = false;
          res.msg = e.message.toString();
        }
    } catch (er) {
        res.result = false;
        res.msg = er.toString();
    }
    return res;
  }

  Future<Result> signOut() async {
    Result result = Result(false, '');
    try{
      _auth.signOut();
      result.result = true;
    }catch(e){
      result.result = false;
      result.msg = e.toString();
    }
    return result ;
  }

  Future<int> getRoleID(String email, String password) async {
    int result = 0;

    await _firestore
        .collection('icovid_user')
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        result = element["roleID"];
      });
    });
    return result;
  }

  Future<Result> regisLogin(String firstname, String lastname, String email, String cid,String tel, String password) async {
      Result res = Result(false, '');
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
            res.result = true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          res.result = false;
          res.msg = 'กรุณาระบุรหัสผ่านให้มีความยาว 6 ตัวอักษรขึ้นไป';
        } else if (e.code == 'email-already-in-use') {
          res.result = false;
          res.msg = 'มีอีเมล์นี้ในระบบแล้ว โปรดใช้อีเมล์อื่น';
        }else{
          res.result = false;
          res.msg = e.message.toString();
        }
      } catch (er) {
        print(er);
        res.result = false;
        res.msg = er.toString();
      }
      return res;
    }

  @override
  Future<void> addUserInfo(String firstname, String lastname, String email, String cid, String tel, String password) {
    return _ref
      .add({
        'cid': cid,
        'firstName': firstname,
        'lastName': lastname,
        'email': email,
        'tel': tel,
        'password': password,
        'roleID': 2,
        'roleName': 'ผู้ใช้งานทั่วไป',
        'position':'',
        'hospitalID':0,
        'hospitalName':'',
        'createDate':DateTime.now(),
      })
      .then((value) => print("User Add"))
      .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Future<UserProfileProvider> getUserInfo(String email) async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('icovid_user').where('email', isEqualTo: email).get();
    SingleUser user = SingleUser.fromJson(snapshot);
    UserProfileProvider profile = UserProfileProvider();
    profile.empcode = user.user.empcode;
    profile.email = user.user.email;
    profile.firstName = user.user.firstName;
    profile.lastName = user.user.lastName;
    profile.password = user.user.password;
    profile.position = user.user.position;
    profile.roleID = user.user.roleID;
    profile.roleName = user.user.roleName;
    profile.tel = user.user.tel;
    return profile;
  }
}