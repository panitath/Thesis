import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';


 class emp_leave extends ChangeNotifier{
 String? leaveid;
 DateTime? startdate;
 DateTime? enddate;
 String? comment;
 //notifyListener();

  emp_leave({this.leaveid,this.startdate, this.enddate, this.comment});
}

