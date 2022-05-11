import 'package:first_app/model/clock.dart';
import 'package:first_app/model/user_profile_provider.dart';
import 'package:first_app/pages/profilem_page.dart';
import 'package:provider/provider.dart';
import 'package:first_app/controller/clock_controller.dart';
import 'package:first_app/model/clock_provider.dart';
import 'package:first_app/pages/leave_page.dart';
import 'package:first_app/services/clock_service.dart';
import 'package:flutter/material.dart';
import 'clock.dart';
import 'time_in_hour_and_minute.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

    Position? _currentPosition;
  String? _currentAddress;
    String? currentAddress;
  var services = ClockService();
  var controller;
  _BodyState() {
    controller = ClockController(services);
  }

 late Position userLocation;


//  @override
//   void initState() {
//     super.initState();
//     setState(() {});
    
//      _getCurrentLocation();
//   }
 

  @override
  Widget build(BuildContext context) {
    int? empcode = context.read<UserProfileProvider>().empcode;
      
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            // Text(
            //   "Newport Beach, USA | PST",
            //   style: Theme.of(context).textTheme.bodyText1,
            // ),
            TimeInHourAndMinute(),
            // Spacer(),
            ClockPage(),
            //Spacer(),
            SizedBox(width: 100, height: 40),
            SizedBox(
            width: 300,
                    height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
                child: Text("บันทึกเวลา", style: TextStyle(fontSize: 18)),
                onPressed: () {
                context.read<ClockProvider>().empcode = empcode;
                  context.read<ClockProvider>().clocktime = DateTime.now();
                  context.read<ClockProvider>().currentlocation =
                      _currentPosition.toString();

                  context.read<ClockProvider>().createdate = DateTime.now();

                  List<ClockList> Listempleave = [];
                  if (context.read<ClockProvider>().empclockList != null) {
                    // Listempleave = context
                    //     .read<EmpleaveProvider>()
                    //   .empleaveList;
                  }
                  _getLocation() ;
                  //add to State
                  Listempleave.add(ClockList(50872, DateTime.now(),
                      _currentPosition.toString(), DateTime.now()));

                  //add to firebase
                 
                  print('ss' + _currentPosition.toString());
                   print('ss' + currentAddress.toString());
            final snackBar = SnackBar(
            content:  Text("บันทึกเวลาทำงาน ${DateTime.now().hour}.${DateTime.now().minute} น.", style: TextStyle(fontSize: 18)),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                
               
                               }, //child: const Text('Show SnackBar'),
));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);          
        },
       
                
              ),
            ),
            //   SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     child: Row(
            //       children: [
            //         CountryCard(
            //           country: "New York, USA",
            //           timeZone: "+3 HRS | EST",
            //           iconSrc: "assets/icons/Liberty.svg",
            //           time: "9:20",
            //           period: "PM",
            //         ),
            //         CountryCard(
            //           country: "Sydney, AU",
            //           timeZone: "+19 HRS | AEST",
            //           iconSrc: "assets/icons/Sydney.svg",
            //           time: "1:20",
            //           period: "AM",
            //         ),
            //       ],
            //     ),
            //   )
          ],
        ),
      ),
    );
  }

  //  void  getCurrentLocation() {
     
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //       _getAddressFromLatLng();
  //       print(_currentPosition);
  //     });
  //   }).catchError((e) {
  //     print('pp'+e);
  //   });
  
  
  
  // }
Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
     setState(() {
        _currentPosition = userLocation;
        _getAddressFromLatLng();
        print(_currentPosition);
      });
    return userLocation;
  }



  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
            currentAddress =_currentAddress ;
        
         controller.addClock(new Clock(50872, DateTime.now(),
                       _currentAddress.toString(), DateTime.now()));
      });
    } catch (e) {
      print(e); return _currentAddress.toString();
      
    }
  }
}
