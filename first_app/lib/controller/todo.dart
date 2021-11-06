import 'dart:async';

import 'package:first_app/model/todo.dart';
import 'package:first_app/services/services.dart';

class TodoController{
  final Services services;
  List<Todo> todos = List.empty();

  StreamController<bool> onSyncController = StreamController();
  Stream<bool> get onSync => onSyncController.stream;

  TodoController(this.services);
  Future<List<Todo>> fectTodos() async{
    onSyncController.add(true);
    todos = await services.getTodos();
    onSyncController.add(false); // ดึงข้อมูลเสร็จแล้ว
    return todos;
  }
}