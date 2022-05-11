import 'package:first_app/constants/color_constant.dart';
import 'package:first_app/pages/approve_all_page.dart';
import 'package:first_app/pages/approve_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'profilem_page.dart';

class ManagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
                    'รายการอนุมัติ',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),
                  ),),
        
        body: Padding(
          padding: const EdgeInsets.only(top: 30, right: 20, left: 20),
          child: Column(children: [
            Container(
                height: 100,
                width: 400,
                child: ElevatedButton.icon(
                  icon: SvgPicture.asset(
                    'assets/images/alarm.svg',
                    width: 50,
                  ),
                  label: Text(
                    '  รายการรออนุมัติ',
                    style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Approve()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: iWhiteColor,
                    enabledMouseCursor: MouseCursor.uncontrolled,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                )),
            SizedBox(height: 50),
            Container(
                height: 100,
                width: 400,
                child: ElevatedButton.icon(
                    icon: SvgPicture.asset(
                      'assets/images/ok.svg',
                    ),
                    label: Text(
                      'รายการอนุมัติทั้งหมด',
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Approve_All()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: iWhiteColor,
                        enabledMouseCursor: MouseCursor.uncontrolled,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                        ))))
          ]),
        ));
  }
}
