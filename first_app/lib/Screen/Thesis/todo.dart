import 'package:first_app/controller/todo.dart';
import 'package:first_app/model/todo.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  final TodoController controller;
  TodoPage({required this.controller});

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo> todos = List.empty();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.controller.onSync
        .listen((bool synState) => setState(() => isLoading = synState));
  _getTodos(); 
  }

  void _getTodos() async {
    var newTodos = await widget.controller.fectTodos();

    setState(() {
      todos = newTodos;
    });
  }

  Widget get body => isLoading
      ? CircularProgressIndicator()
      : ListView.builder(
          itemCount: todos.isEmpty ? 1 : todos.length,
          itemBuilder: (context, index) {
            if (todos.isEmpty) {
              return Text('Tap button to fetch Todos');
            }
            return //Text(todos[index].comment);
                // CheckboxListTile(
                //   value: true,
                //   onChanged: null,
                //   title: Text(todos[index].comment),
                //   );
                Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: FittedBox(
                    child: Text(
                      '${index + 1}',
                      //style: TextStyle(color: iWhiteColor,fontSize: 20),
                    ),
                  ),
                ),
                title: Text(todos[index].leaveid.toString()),
                subtitle: Text(todos[index].startdate.toString()),
                onTap: () {
                  // Navigator.push(
                  //   context,
                  // MaterialPageRoute(
                  //   builder: (context) =>  EmpleaveDetail(Empleaves: _empleaveList[index]),
                  // ),
                  // );
                },
              ),
            );
          },
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายการลาหยุด'),
      ),
      body: Center(
        child: body,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _getTodos,
        child: Icon(Icons.add),
      ),
    );
  }
}
