import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
class Todo{
final int empcode;
final int leaveid;
final DateTime startdate;
final DateTime enddate;
final String comment;
Todo(this.empcode,this.leaveid,this.startdate,this.enddate,this.comment);



factory Todo.fromJson(Map<String,dynamic> json,){
  return Todo(
    json['empcode'] as int,
    json['leaveid'] as int,
    json['startdate'].toDate() as DateTime,
    json['enddate'].toDate() as DateTime,
    json['comment'] as String,
  );
  
}

}

class AllTodos{
  final List<Todo> todos;
  AllTodos (this.todos);

  factory AllTodos.fromJson(List<dynamic> json){
    List<Todo> todos ;
    todos = json.map((index) => Todo.fromJson(index)).toList();
    return  AllTodos(todos);
  
    }
    factory AllTodos.fromSnapshot(QuerySnapshot s){
      List<Todo> todos = s.docs.map((DocumentSnapshot ds) { 
       
       return Todo.fromJson(ds.data() as Map<String,dynamic>);
      }).toList();
      return AllTodos(todos);
    }
}
