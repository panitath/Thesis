import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:first_app/model/todo.dart';
import 'package:http/http.dart';

abstract class Services{
  Future<List<Todo>> getTodos();
}
class FirebaseServices extends Services{
  @override
  Future <List<Todo>> getTodos() async{
    QuerySnapshot snapshot = 
   await  FirebaseFirestore
   .instance
   .collection('todos')
   .get();

   AllTodos todos = AllTodos.fromSnapshot(snapshot);
   return todos.todos;
}}

class HttpServices extends Services{
 
  Client client = Client();

  Future<List<Todo>> getTodos() async{
    final response = await client.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/todos'));
      if(response.statusCode == 200){
        var all = AllTodos.fromJson(
          json.decode(response.body),
        );
        return all.todos;

      }
    throw Exception('Failed to load todos');

  }
}

