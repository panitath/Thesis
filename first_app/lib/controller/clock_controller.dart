import 'dart:async';
import 'package:first_app/model/clock.dart';
import 'package:first_app/services/clock_service.dart';


class ClockController{
  final ClockServices service;
  List<Clock> clock = List.empty();
   List<Clock> clockList = List.empty();


  StreamController<bool> onSyncController = StreamController<bool>.broadcast();
  Stream<bool> get onSync => onSyncController.stream;
  StreamController<bool> onSyncHosBookingController = StreamController<bool>.broadcast();
  Stream<bool> get onSyncHosBooking => onSyncHosBookingController.stream;
  
  bool _isDisposed = false;
  ClockController(this.service);
  
 

  void addClock(Clock items) async {
    service.addClock(items);
  }

  void dispose() {
    onSyncHosBookingController.close();
    _isDisposed = true;
  }

}