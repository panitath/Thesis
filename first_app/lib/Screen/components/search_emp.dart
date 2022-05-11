import 'package:first_app/controller/empleave_controller.dart';
import 'package:first_app/model/deligate_provider.dart';
import 'package:first_app/model/emp_api_model.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/services/empleave_services.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';


class SearchEmp extends StatefulWidget {
   var service = EmpleaveServices();
  var controller;

  SearchEmp() {
     
     controller = EmpleaveController(service);
  }
  @override
  _SearchEmpState createState() => _SearchEmpState();
}

class _SearchEmpState extends State<SearchEmp> {

    List<EmpAPIModel> _empList = List.empty();
    

final TextEditingController _empcodeController = new TextEditingController();
final TextEditingController _fullnameController = new TextEditingController();
  EmpAPIModel? model;
  int? empcode ;

void _getEmp() async {
   
    DateTime fromDate;
    DateTime toDate;

     var response = await widget.controller
        .getemp(_empcodeController.text);
    setState(() {
      model = response;
      String? firstnamedelegate = model!.employee!.employee!.firstname;
      String? lastnamedelegate = model!.employee!.employee!.lastname;
       String? empcodemanager = model!.employee!.employee!.empcodemanager;
      String? firstnamemanager = model!.employee!.employee!.firstnamemanager;
      String? lastnamemanager = model!.employee!.employee!.lastnamemanager;
      String? emailmanager = model!.employee!.employee!.emailmanager;
      String? empcodedelegate = model!.employee!.employee!.empcode;

       context.read< DelegateProvider>().empcodemanager = int.parse(empcodemanager!);
       context.read< DelegateProvider>().managername = '${firstnamemanager}'+'  ' +'${lastnamemanager}';
       context.read< DelegateProvider>().empcodedelegate = int.parse(_empcodeController.text);
        context.read< DelegateProvider>().delegatename = '${firstnamedelegate}'+'  ' +'${lastnamedelegate}';
       context.read< DelegateProvider>().manageremail  = emailmanager;
       if(empcode == int.parse(empcodedelegate.toString())){

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('ไม่สามารถมอบหมายปฏิบัติหน้าที่แก่ตนเองได้'),
        duration: Duration(seconds: 5),
      ));

       }

                                                      
       _fullnameController.text = 'ชื่อ - สกุล : '+'${firstnamedelegate}'+'  ' +'${lastnamedelegate}' ;
   });
   }
 
  @override
  Widget build(BuildContext context) {
     empcode = context.read<UserProfileProvider>().empcode;
      
    return   Padding(
      padding: const EdgeInsets.all(15.0),
      child: SafeArea(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(children: <Widget>[
                          
                             SizedBox(height: 40),
                              Row(
                                children: [
                                  Text("ค้นหารหัสพนักงาน\n",
                                      style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                ],
                              ),

                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(29.5),
                                  ),
                                  child: TextFormField(
                                      controller: _empcodeController,
                                      decoration: InputDecoration(
                                        hintText: "ค้นหา",
                                        border: InputBorder.none,
                                        suffixIcon: IconButton(
                                          onPressed: () => _getEmp(
                                              ),
                                          icon: Icon(Icons.search),
                                        ),
                                      ))),
                              TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                 // labelText: 'ชื่อ นามสกุล',
                                  labelStyle: TextStyle(fontSize: 18),
                                  enabledBorder: UnderlineInputBorder(),
                                  focusedBorder: UnderlineInputBorder(),
                                ),
                                controller: _fullnameController,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'กรุณาระบุชื่อ';
                                //   }
                                //   return null;
                                // }
                                )
                            ]
                            )
                        )
      ),
    );
    
                            
  }

   
}
