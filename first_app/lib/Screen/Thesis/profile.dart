
import 'package:first_app/Screen/Thesis/leavelist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Deligate.dart';
import 'leave.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            children: [
             SizedBox(height: 100,
             width: 100,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/Profile.png"),
                ),
              ),
              // Positioned(
              //   right : -12,
              //   bottom : 0,
              //   child:
              //  SizedBox(
              //   height: 46,
              //   width: 46,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: SvgPicture.asset("assetName/images/camera.svg"),
              //   ),
              // )
              // )
            ],
          ),
        ),
        SizedBox(height: 20),
        profilemenu(
          icon: "assets/images/deligate.svg",
          text: "Deligate",
          press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return deligate();
                    }));
                  },
        
        ),
         profilemenu(
          icon: "assets/images/calendar.svg",
          text: "Leave",
          press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return leave();
                    }));
                  },
        ),
         profilemenu(
          icon: "assets/images/leavelist.svg",
          text: "Leavelist",
          press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return leave_list();
                    }));
                  },
        ),
        
         profilemenu(
          icon: "assets/images/Report.svg",
          text: "Report",
          press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return leave();
                    }));
                  },
        ),
      ],
    );
  }
}

class profilemenu extends StatelessWidget {
  const profilemenu({
    Key? key,
    required this.text,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
            primary: Colors.grey[200],
            padding: EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))),
        // textStyle:
        //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              color: Colors.black87,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    );
  }
}
