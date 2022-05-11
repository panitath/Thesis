import 'dart:async';
import 'package:first_app/model/clock.dart';
import 'package:first_app/services/clock_service.dart';


class ClockController{
  final ClockServices service;
  List<Clock> clock = List.empty();
   List<Clock> clockList = List.empty();


   Clock? empclock;


  StreamController<bool> onSyncController = StreamController<bool>.broadcast();
  Stream<bool> get onSync => onSyncController.stream;
  StreamController<bool> onSyncHosBookingController = StreamController<bool>.broadcast();
  Stream<bool> get onSyncHosBooking => onSyncHosBookingController.stream;
  
  bool _isDisposed = false;
  ClockController(this.service);
  
 
  void addClock(Clock items) async {
    service.addClock(items);
  }
Future<List<Clock>> fecthEmpClock(int empcodeclock) async {
    
    if (_isDisposed) {
      onSyncController = StreamController<bool>.broadcast();
    }
    onSyncController.add(true);
    clock = await service.getEmpClockList(empcodeclock);
    onSyncController.add(false);
    dispose();
    return clock;
  }

  void dispose() {
    onSyncHosBookingController.close();
    _isDisposed = true;
  }

}