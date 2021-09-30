
import 'package:first_app/Screen/Thesis/leave.dart';
import 'package:first_app/Screen/Thesis/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'clock.dart';
import 'country_card.dart';
import 'time_in_hour_and_minute.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Clock(),
            //Spacer(), 
             SizedBox(
                width: 100,
                 height: 40),
            SizedBox(
                width: 150,
                 height: 40,
                 
                child: ElevatedButton(
                  child: Text("บันทึกเวลา"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return leave();
                    }));
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
}