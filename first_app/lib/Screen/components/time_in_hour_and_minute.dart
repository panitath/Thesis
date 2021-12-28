import 'dart:async';

import 'package:flutter/material.dart';

import '../../../size_config.dart';


class TimeInHourAndMinute extends StatefulWidget {
  @override
  _TimeInHourAndMinuteState createState() => _TimeInHourAndMinuteState();
}

class _TimeInHourAndMinuteState extends State<TimeInHourAndMinute> {
  //TimeOfDay _timeOfDay = TimeOfDay.now();
    String? _timeOfDay;
  @override
  void initState() {
    super.initState();
    //  Timer.periodic(Duration(seconds: 1), (timer) {
    //   if (_timeOfDay.minute != TimeOfDay.now().minute) {
    //     setState(() {
    //       _timeOfDay = TimeOfDay.now();
    //     });
    //   }
    // });
_timeOfDay = "${DateTime.now().hour} : ${DateTime.now().minute} :${DateTime.now().second}";
    Timer.periodic(Duration(seconds:1), (Timer t)=>_getCurrentTime());
   

  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // String _period = _timeOfDay.period == DayPeriod.am ? "AM" : "PM";
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
          Text(
            // if you use _timeOfDay.hour then it will show 20:10 like that
            // But we want 8:10
            //"${_timeOfDay.hourOfPeriod}:${_timeOfDay.minute}:${_timeOfDay.secound}",
            _timeOfDay.toString(), //style: TextStyle(fontSize: 30),),
            style: TextStyle(fontSize: 50.0,color: Colors.black54,)
          ),
          SizedBox(width: 5),
          // RotatedBox(
          //   quarterTurns: 3,
          //   child: Text(
          //     _period,
          //     style: TextStyle(fontSize: getProportionateScreenWidth(18)),
          //   ),
          // ),
        ],
      ),
    );
  }
 void _getCurrentTime()  {
    setState(() {
      String hour = DateTime.now().hour.toString();
      String minute = DateTime.now().minute.toString();
      String second = DateTime.now().second.toString();
      String showhour = "${DateTime.now().hour}" ;
      String showminute = "${DateTime.now().minute}" ;
      String showsecond = "${DateTime.now().second}" ;

if(hour.length ==1){
  showhour = "0${DateTime.now().hour}" ;
}
if(minute.length ==1){
 showminute = "0${DateTime.now().minute}" ;
}
if(second.length ==1){
 showsecond = "0${DateTime.now().second}" ;
}
   
   _timeOfDay = showhour+" : "+showminute+" : "+showsecond;

    });
  }
}


// String hour = DateTime.now().hour.toString();
//       String minute = DateTime.now().minute.toString();
//       String second = DateTime.now().second.toString();
//       String time = hour+":"+minute+":"+second;