
import 'package:first_app/model/emp_leave.dart';
import 'package:flutter/material.dart';


 class Emp_leavelist extends ChangeNotifier{
 List<Empleave> transactions = [Empleave(leaveid:"ลาพักผ่อน",startdate: DateTime.now(),enddate: DateTime.now(),comment: "zz")];

List<Empleave> getTransaction(){
  return transactions;
}
void addTransaction(Empleave statement){
  transactions.add(statement);
}

}